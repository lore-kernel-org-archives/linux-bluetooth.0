Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <30D5A9D0-8BBC-44FD-8E13-5C7C9A52619B@holtmann.org>
References: <1467964987-6402-1-git-send-email-wu.zheng@intel.com> <30D5A9D0-8BBC-44FD-8E13-5C7C9A52619B@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 Jul 2016 00:52:15 +0300
Message-ID: <CABBYNZ+iS7neCkKQPebz0WRPOZnWpO+dxywxyz3RnOV2qZ7GQw@mail.gmail.com>
Subject: Re: [PATCH] Fix bluez5 capabilities for Smack setup
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Zheng, Wu" <wu.zheng@intel.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 8, 2016 at 12:07 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Wu,
>
>> Recent bluez5 releases started limiting the capabilities of
>> bluetoothd. When running on a Smack-enabled system, that change has the
>> effect that bluetoothd can no longer create the input device under
>> /sys because bluez5 running with label "System" has no write
>> access to that.
>>
>> It works when running as normal root with unrestricted capabilities
>> because then CAP_MAC_OVERRIDE (a Smack-specific capability) allows
>> the process to ignore Smack rules.
>>
>> We need to ensure that bluetoothd still has that capability.
>> ---
>> src/bluetooth.service.in | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
>> index f799f65..1b0fead 100644
>> --- a/src/bluetooth.service.in
>> +++ b/src/bluetooth.service.in
>> @@ -10,7 +10,7 @@ ExecStart=@libexecdir@/bluetoothd
>> NotifyAccess=main
>> #WatchdogSec=10
>> #Restart=on-failure
>> -CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
>> +CapabilityBoundingSet=CAP_MAC_OVERRIDE CAP_NET_ADMIN CAP_NET_BIND_SERVICE
>
> this looks like the big hammer approach. I think if this is needed, then the Smack policies are just wrong. Why not fix them instead of punching such a big hole into it.

+1, CAP_NET_ADMIN would have that capability since it is stated:

 CAP_NET_ADMIN
              Perform various network-related operations:
              * interface configuration;



-- 
Luiz Augusto von Dentz
