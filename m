Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 10:18:20 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
    marcel@holtmann.org
Subject: Re: [PATCHv1 01/17] Bluetooth: A2MP: Create A2MP channel
In-Reply-To: <20120525080904.GF3089@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1205250918520.2070@mathewm-linux>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1337351150-20526-2-git-send-email-Andrei.Emeltchenko.news@gmail.com> <alpine.DEB.2.02.1205221039100.2239@mathewm-linux> <20120523074950.GA32022@aemeltch-MOBL1>
 <alpine.DEB.2.02.1205230842040.6526@mathewm-linux> <20120524075105.GB24715@aemeltch-MOBL1> <alpine.DEB.2.02.1205240853590.18142@mathewm-linux> <20120525080904.GF3089@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Fri, 25 May 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Thu, May 24, 2012 at 08:59:57AM -0700, Mat Martineau wrote:
>> On Thu, 24 May 2012, Andrei Emeltchenko wrote:
>>> On Wed, May 23, 2012 at 08:44:22AM -0700, Mat Martineau wrote:
>>>>>>> +static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
>>>>>>> +{
>>>>>>> +	struct l2cap_chan *chan;
>>>>>>> +
>>>>>>> +	chan = l2cap_chan_create();
>>>>>>> +	if (!chan)
>>>>>>> +		return NULL;
>>>>>>> +
>>>>>>> +	BT_DBG("chan %p", chan);
>>>>>>> +
>>>>>>> +	hci_conn_hold(conn->hcon);
>>>>>>
>>>>>> Holding the hcon will keep the ACL open after all of the other L2CAP
>>>>>> channels have closed (unless I missed some code later in the patch
>>>>>> series).  The A2MP fixed channel should not keep the ACL open.  If
>>>>>> the connection is not held here, then there shouldn't be a put in
>>>>>> l2cap_chan_del for the A2MP channel either.
>>>>>
>>>>> l2cap_chan_del makes hci_conn_put, also for a2mp channel. The behavior is
>>>>> the same for fixed and normal channels.
>>>>
>>>> And when does l2cap_chan_del get called for a fixed channel?  The
>>>> fixed channel must not do an hci_conn_hold so the ACL is allowed to
>>>> close when all dynamic L2CAP channels have closed.
>>>
>>> The current approach is to have amp_mgr for hci_conn. It will be freed
>>> when in hci_conn_del together with other l2cap channels in
>>> hci_chan_list_flush and then we make amp_mgr_put() and destroy mgr.
>>>
>>> The idea is to make a2mp chan similar to other chans and other chans do
>>> hci_conn_hold and hci_conn_put. Otherwise I would need to add extra checks
>>> before hci_conn_put which is ugly.
>>>
>>> I've tested this with PTS and no memory leaks found so far.
>>
>> The risk is not memory leaks - if the other device closes the ACL,
>> then the A2MP channel will be cleaned up.  But if you had two BlueZ
>> devices with A2MP connected to each other, the ACL would never close
>> as long as the devices remained powered and in range!  Nothing would
>> trigger the flush as long as the hci_conn is held.
>
> Does it indicate that we have problem with rather freeing amp_mgr?

It looks like the amp_mgr will be freed if the channel is closed. 
There's nothing that will close the channel except for:

* Remote device disconnects the ACL
* Remote device goes out of range
* Local BR/EDR controller is powered down or reset

>> I think the checks for hci_conn_put are necessary, even if they are
>> ugly.
>
> I think that if I have hci_conn_hold when creating channel and
> hci_conn_put when closing channel that does not differ from the case when
> I do not have hci_conn_put/hold.

If there was something that closed the A2MP channel, there would be no 
difference.  But nothing closes the A2MP channel.

> So you are probably referring to the case when hci_conn needs to be closed
> but cannot because it has hci_conn_hold in a2mp channel?

Yes.

> This also means that we still have L2CAP channel (a2mp) hanging.
> This seems right to me if I did not miss something.

Since A2MP is a fixed channel, it is not opened and closed like 
typical L2CAP channels.  Consider this scenario:

1. Remote device decides to connect
2. ACL is created
3. Remote device sends A2MP discover
4. A2MP channel is set up, AMP manager is created, hci_conn_hold for 
A2MP channel
5. Remote device connects L2CAP channel over BR/EDR.  hci_conn_hold 
for the data channel
6. A2MP communication to set up physical link
7. L2CAP channel move to AMP controller
8. Data sent over AMP.
9. L2CAP channel disconnected, hci_conn_put for the data channel
10. Device stays in range.  hci_conn reference count is not 0, so ACL 
is not closed.

If you reach step 10 and both sides are BlueZ, the ACL stays active 
and BT is using extra power.

If you did not do the hci_conn_hold in step 4, the ACL would be 
disconnected 2 seconds after step 9, allowing the BR/EDR baseband to 
go in to a low power state.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
