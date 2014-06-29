Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1404035356-37352-1-git-send-email-marcel@holtmann.org>
References: <1404035356-37352-1-git-send-email-marcel@holtmann.org>
Date: Sun, 29 Jun 2014 20:21:33 +0200
Message-ID: <CAN_7+YajEYwDHqJpVBtiwLcZiZb7_-A5E7QUpLvHNRE3byM_0Q@mail.gmail.com>
Subject: Re: [PATCH] doc: Add management command for adding devices for
 passive scanning
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

On Sun, Jun 29, 2014 at 11:49 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> ---
>  doc/mgmt-api.txt | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index d329d4a66d9c..d428f7718512 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -1866,6 +1866,68 @@ Get Clock Information Command
>                                 Invalid Index
>
>
> +Add Device Command
> +==================
> +
> +       Command Code:           0x0034
> +       Controller Index:       <controller id>
> +       Command Parameters:     Address (6 Octets)
> +                               Address_Type (1 Octet)
> +                               Action (1 Octet)
> +       Return Parameters:
> +
Address and address type will be useful in the return parameters.
For example,  application wants to set auto connect to many devices.
In that case daemon should be able to reply with success or failure
for each of device.
For sure it will be useful in Android case.

> +       This command is used to add a device to the action list. The
> +       action list allows scanning for devices and auto-connection
> +       to known devices.
> +
> +       Possible values for the Action parameter:
> +               0       Background scan for device
> +               1       Auto-connect device
> +
> +       With the Action 0, when the device is found, a new Device Found
> +       event will be send indicating this device is available. Devices
> +       using direct advertising will be connected.
> +
> +       With the Action 1, when the device is found, it will be connected
> +       and if successful a Device Connected event will be send.
> +
> +       This command can be used when the controller is not powered and
> +       all settings will be programmed once powered.
> +
> +       This command generates a Command Complete event on success or
> +       a Command Status event on failure.

Command Complete on failure would be better, so daemon can get an idea
for which device command failed.

> +
> +       Possible errors:        Busy
> +                               Invalid Parameters
> +                               Invalid Index
> +
> +
> +Remove Device Command
> +=====================
> +
> +       Command Code:           0x0035
> +       Controller Index:       <controller id>
> +       Command Parameters:     Address (6 Octets)
> +                               Address_Type (1 Octet)
> +       Return Parameters:
> +
I think we should have similar approach here as for above command.
Meaning, use address and type in th return parameters.

> +       This command is used to remove a device from the action list
> +       previously added by using the Add Device command.
> +
> +       When the Address parameter is 00:00:00:00:00:00, then all
> +       previously added devices wil be removed.
> +
> +       This command can be used when the controller is not powered and
> +       all settings will be programmed once powered.
> +
> +       This command generates a Command Complete event on success or
> +       a Command Status event on failure.

Similar here.

> +
> +       Possible errors:        Busy
> +                               Invalid Parameters
> +                               Invalid Index
> +
> +
>  Command Complete Event
>  ======================
>
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR
Lukasz
