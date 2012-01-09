Return-Path: <cyrus@holtmann.org>
Message-ID: <4F0AA5A2.4070903@monom.org>
Date: Mon, 09 Jan 2012 09:30:26 +0100
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: Peter Hurley <peter@hurleysoftware.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Fix l2cap conn failures for ssp devices
References: <1312921615.2261.1.camel@THOR> <4F04285E.1070500@monom.org>
In-Reply-To: <4F04285E.1070500@monom.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 04.01.2012 11:22, Daniel Wagner wrote:
> Hi Peter,
> 
> On 09.08.2011 22:26, Peter Hurley wrote:
>> Commit 330605423c fixed l2cap conn establishment for non-ssp remote
>> devices by not setting HCI_CONN_ENCRYPT_PEND every time conn security
>> is tested (which was always returning failure on any subsequent
>> security checks).
>>
>> However, this broke l2cap conn establishment for ssp remote devices
>> when an ACL link was already established at SDP-level security. This
>> fix ensures that encryption must be pending whenever authentication
>> is also pending.
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> 
> git am complaines:
> 
> Applying: Bluetooth: Fix l2cap conn failures for ssp devices
> /home/wagi/src/bluetooth-next/.git/rebase-apply/patch:18: trailing whitespace.
> 
> /home/wagi/src/bluetooth-next/.git/rebase-apply/patch:19: trailing whitespace.
>                 /* encrypt must be pending if auth is also pending */
> /home/wagi/src/bluetooth-next/.git/rebase-apply/patch:20: trailing whitespace.
>                 set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend);
> /home/wagi/src/bluetooth-next/.git/rebase-apply/patch:21: trailing whitespace.
> 
> 
> But it fixes the problem I was debugging. From what I have
> learned in the last two days I would say it is also the right fix :)

Is there any chance to get this patch in? If it helps I could send a
whitespace fixed version.

cheers,
daniel
