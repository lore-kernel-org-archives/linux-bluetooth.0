Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C019B2D1-71D5-4054-8FBC-A49CB7F25633@holtmann.org>
References: <1375025201-18139-1-git-send-email-syamsidhardh@gmail.com>
	<C019B2D1-71D5-4054-8FBC-A49CB7F25633@holtmann.org>
Date: Tue, 6 Aug 2013 01:47:46 +0900
Message-ID: <CAFBvHifVV2KbWuQ=Nc_PmGh7yU8FtBariZBvhk4q_vd2TUzwmw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: Fix ACL alive for long in case of non
 pariable devices
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: User Name <linux-bluetooth@vger.kernel.org>, Syam Sidhardhan <s.syam@samsung.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jul 29, 2013 at 7:13 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Syam,
>
>> For certain devices (ex: HID mouse), support for authentication,
>> pairing and bonding is optional. For such devices, the ACL alive
>> for too long after the L2CAP disconnection.
>>
>> To avoid the ACL alive for too long after L2CAP disconnection, reset the ACL
>> disconnect timeout back to HCI_DISCONN_TIMEOUT during L2CAP connect.
>>
>> While merging the commit id:a9ea3ed9b71cc3271dd59e76f65748adcaa76422
>> this issue might have introduced.
>>
>> Signed-off-by: Sang-Ki Park <sangki79.park@samsung.com>
>> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
>> ---
>> v1 -> Modified the code as per the latest code.
>> v2 -> Add descriptive comment as per Marcel request.
>> v3 -> Moved from l2cap_conn_ready() to l2cap_connect() inorder to fix remote
>>      non ssp pairing timeout. Generated the patch based on bluetooth.git tree.
>>
>> net/bluetooth/l2cap_core.c |    7 +++++++
>> 1 file changed, 7 insertions(+)
>
> is the any chance you have btmon or hcidump traces that would show this kind of behavior. Adding these to the commit message might be really helpful in case we have understand again why we did this.

Yes, I found the particular mouse device after a long search and
captured the hcidump log.
I'll send another patch version with the logs. Sorry for the delay.

Regards,
Syam
