Return-Path: <cyrus@holtmann.org>
Message-ID: <4F2A592F.60008@monom.org>
Date: Thu, 02 Feb 2012 10:36:47 +0100
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 Peter Hurley <peter@hurleysoftware.com>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Fix l2cap conn failures for ssp devices
References: <1312921615.2261.1.camel@THOR> <1328141557.2054.0.camel@aeonflux> <20120202002614.GA11905@x220.globalsuite.net>
In-Reply-To: <20120202002614.GA11905@x220.globalsuite.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

On 02.02.2012 01:26, Johan Hedberg wrote:
> Hi,
> 
> On Wed, Feb 01, 2012, Marcel Holtmann wrote:
>>> Commit 330605423c fixed l2cap conn establishment for non-ssp remote
>>> devices by not setting HCI_CONN_ENCRYPT_PEND every time conn security
>>> is tested (which was always returning failure on any subsequent
>>> security checks).
>>>
>>> However, this broke l2cap conn establishment for ssp remote devices
>>> when an ACL link was already established at SDP-level security. This
>>> fix ensures that encryption must be pending whenever authentication
>>> is also pending.
>>>
>>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>>> ---
>>>
>>> v2: Avoids possible race condition between hci_conn_security and
>>> hci_conn_complete_evt
>>> v3: Actually compiles :)
>>>
>>>  net/bluetooth/hci_conn.c |    4 ++++
>>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> 
> The patch is now in my bluetooth-next tree after manually fixing
> conn->pend to conn->flags (otherwise the patch wouldn't apply).

You might consider to send this one to stable as well. At least 3.0
could really need this patch, since it is long time stable tree, IIRC.

cheers,
daniel
