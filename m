Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56DDD109.5040701@prudentl.com>
References: <56DDD109.5040701@prudentl.com>
Date: Tue, 8 Mar 2016 14:58:43 +0200
Message-ID: <CABBYNZ+fRtaXrnpw9G87So5ar_W8zWac9SJpebTcsRPuddp2zw@mail.gmail.com>
Subject: Re: Bluez LE: Unable to get readings from LE devices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ron Harding <ron@prudentl.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

On Mon, Mar 7, 2016 at 9:05 PM, Ron Harding <ron@prudentl.com> wrote:
>> 'No bonding' is used when the device is performing a
>> Secure Simple Pairing procedure, but does not intend to retain the link
>> key
>> after the physical link is disconnected.
>>
>> I would keep the policy of not redoing the pairing automatically in
>> case of missing link key error but perhaps the agent shall be called
>> in such case and then depending on the response start a new pairing,
>> so we keep this policy in the agent. Nevertheless it is still a good
>> idea to set the "No bonding' value in case you want to avoid this
>> extra steps while reconnecting.
>
>
> Your explanation of how the "PIN or Key Missing" status could arise matches
> what I thought might be happening.
>
> But I'm having trouble figuring out how to implement your suggested fix.  I
> know "No Bonding" is one of the values
> that can be specified in the AuthReq field of a pairing request.  But I
> don't see how I, as a user of BlueZ, can
> tell it to do so.  There doesn't seem to be anything in either
> org.bluez.Device1 or org.bluez.Agent1 for it.
>
> I think maybe you're suggesting that the LE device it should be specifying
> "No Bonding".  If it's not going to
> store the Link Key, then indeed it probably should.  But unfortunately we
> can't change that: we don't make the device.

In that case we would have to expose the 'No Bonding' setting somehow,
we do have that already as bondable flag which you can set via MGMT
command, but perhaps you only want to set when pairing with a certain
device to force it not store the link keys which would probably
involving changing APIs. Then again the ideal solution would be for
the LE peripheral to actually tell its capabilities properly.

In the other hand perhaps we should focus on "PIN or Key Missing"
which is something that can happen when one of the sides remove the
link key locally which is much more common, perhaps starting a new
pairing and having the user agent to accept/reject the new pairing
would be a better fix for this problem.

-- 
Luiz Augusto von Dentz
