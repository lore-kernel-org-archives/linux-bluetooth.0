Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5A9C4167D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 18:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjJaSFb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Oct 2023 14:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjJaSF3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Oct 2023 14:05:29 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C9EF7
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 11:05:21 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so85435711fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698775520; x=1699380320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4sCKwieW/oMAPNzdqsi1mXK08ZUZDbJllO74CwPSMk=;
        b=hSLTdLUYp1ih7VcrHYfysQfHK4gQaZRJy5/tpcfs4I/x+LFJ2b7gn+mPL4MdzASR/r
         Xz5aDQY0IteX02NjaM/fBT9tSFQiS7ZjzjX3FwYFLo5eI+M3B63lZalmcOv6vNSd2DPP
         QOsMyBRhebtbAW0CuXb7anG84dKdsFF1zIGAmQhUYpG+vD/eslhvbasT1g1TeDxTAyv2
         g+CE3tSt0rnzcxvbinPJCluHMLCmD531LhauPFlDaSjl8W7xHPks28U8Zz3v9Evi+mK7
         IY5plazMQGwclMIOZvlrcRoTutocjaJ0mheZrGCACHqTABQVZ8i5T6xKdLeCdLYDCHXd
         btnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775520; x=1699380320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4sCKwieW/oMAPNzdqsi1mXK08ZUZDbJllO74CwPSMk=;
        b=V2G9t1Aaz7flcCi5n/IT1fADsPBRI4pJKcticOqaAEpHoTlfmB0E09+BpKL6qNeNUt
         CmgCdXapj+E5eSORkI3OPGD8CYz+vQZnAgIjzoDDeqq6so55NPQ3QAo/E+SN55d9FeYK
         mp4RmKPHKu088DwWDkzEoh1Z75E3ncJg+X3fWr67XmsFil67so/DdhkGLicjQZQ4qjA7
         S3lGA5/JUJlqqZc91QY2YIWSzmMTGXpZ20rvhfuwfB7VqzTTcRzImFcaV+iqMxdjdVsX
         W0fYvSaPkLRS+AnS4Vm5al+RMD85jhbfedprHT7kX0xuj9xh/7SUV9UWwH/qUwKULw24
         p0/Q==
X-Gm-Message-State: AOJu0YyMuVo71Vzsno8rjxHJdVSrKS056i1syVvoQPyBV8XzXCVyQr0r
        AQu8J7fGt35ohhvC2eYEdsQEq63VUuTranB7q2k=
X-Google-Smtp-Source: AGHT+IFGxziZRUOVJh2yKXsYa9LsY/z0/ZJA7MRSVZinekxazq68ozWBkpO6aIYkAOLus1OHTVZcUrTAmO9GAlFKr9k=
X-Received: by 2002:a2e:80c7:0:b0:2c5:968:6daf with SMTP id
 r7-20020a2e80c7000000b002c509686dafmr10564155ljg.39.1698775519112; Tue, 31
 Oct 2023 11:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231028115342.62489-1-potto@vt.edu> <20231028115342.62489-2-potto@vt.edu>
In-Reply-To: <20231028115342.62489-2-potto@vt.edu>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 31 Oct 2023 11:05:07 -0700
Message-ID: <CABBYNZ+xcR1+H3U7enOspLODNjXLVrPN9z+Ct1SuXp9o4pHLrA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Updated bluetoothctl documentation.
To:     Paul Otto <potto@vt.edu>
Cc:     linux-bluetooth@vger.kernel.org, Paul Otto <potto@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul,

On Sat, Oct 28, 2023 at 4:54=E2=80=AFAM Paul Otto <potto@vt.edu> wrote:
>
> From: Paul Otto <potto@ieee.org>

I'd split each new document on its own patch if possible, I can do it
myself later when applying but that may take some time since Im
currently on vacation I have very limited time to code.

> ---
>  client/bluetoothctl-admin.rst     |  98 ++++++++
>  client/bluetoothctl-advertise.rst | 243 ++++++++++++++++++++
>  client/bluetoothctl-endpoint.rst  | 121 ++++++++++
>  client/bluetoothctl-gatt.rst      | 212 +++++++++++++++++
>  client/bluetoothctl-player.rst    | 200 ++++++++++++++++
>  client/bluetoothctl-scan.rst      | 146 ++++++++++++
>  client/bluetoothctl-transport.rst | 128 +++++++++++
>  client/bluetoothctl.rst           | 366 ++++++++++++++++++++++++++++++
>  8 files changed, 1514 insertions(+)
>  create mode 100644 client/bluetoothctl-admin.rst
>  create mode 100644 client/bluetoothctl-advertise.rst
>  create mode 100644 client/bluetoothctl-endpoint.rst
>  create mode 100644 client/bluetoothctl-gatt.rst
>  create mode 100644 client/bluetoothctl-player.rst
>  create mode 100644 client/bluetoothctl-scan.rst
>  create mode 100644 client/bluetoothctl-transport.rst
>  create mode 100644 client/bluetoothctl.rst
>
> diff --git a/client/bluetoothctl-admin.rst b/client/bluetoothctl-admin.rs=
t
> new file mode 100644
> index 000000000..7084bdad0
> --- /dev/null
> +++ b/client/bluetoothctl-admin.rst
> @@ -0,0 +1,98 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +bluetoothctl-admin
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +--------------------
> +Admin Policy Submenu
> +--------------------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under ther terms of the=
 GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: November 2022
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl** [**-a** *capability*] [**-e**] [**-m**] [**-t** *second=
s*] [**-v**] [**-h**]
> +
> +DESCRIPTION
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl(1)** interactive bluetooth control tool. The tool works w=
ith Bluetooth Classic (BR/EDR) and Bluetooth Low Energy (LE) controllers.
> +
> +OPTIONS
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +-a capability, --agent capability        Register agent handler: <capabi=
lity>
> +-e, --endpoints                  Register Media endpoints
> +-m, --monitor                    Enable monitor output
> +-t seconds, --timeout seconds    Timeout in seconds for non-interactive =
mode
> +-v, --version       Display version
> +-h, --help          Display help
> +
> +Admin Policy Commands
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   We divide bluetoothctl into main menu commands and submenu commands. =
The submenu commands control options
> +   numbers for the commands can be hex (0x0F) or decimal (10)
> +
> +allow
> +-----
> +   Allow service UUIDs and block rest of them
> +   Syntax: allow [clear/uuid1 uuid2 ...]
> +   Example: allow 0x1101 0x1102 0x1103
> +   Example: allow clear
> +
> +:Usage: **#allow [clear/uuid1 uuid2 ...]**
> +
> +back
> +----
> +   Return to main menu
> +
> +:Usage: **#back**
> +
> +version
> +-------
> +   Display version
> +
> +:Usage: **#version**
> +
> +quit
> +----
> +   Quit program
> +
> +:Usage: **#quit**
> +
> +exit
> +----
> +   Quit program
> +
> +:Usage: **#exit**
> +
> +help
> +----
> +   Display help about this program
> +
> +:Usage: **#help**
> +
> +export
> +------
> +   Print environment variables
> +
> +:Usage: **#export**
> +
> +EXAMPLES
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +RESOURCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +linux-bluetooth@vger.kernel.org
> diff --git a/client/bluetoothctl-advertise.rst b/client/bluetoothctl-adve=
rtise.rst
> new file mode 100644
> index 000000000..7b9911158
> --- /dev/null
> +++ b/client/bluetoothctl-advertise.rst
> @@ -0,0 +1,243 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +bluetoothctl-advertise-options
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +-------------------------
> +Advertise Options Submenu
> +-------------------------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under ther terms of the=
 GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: November 2022
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +bluetoothctl advertise options submenu can be accessed by the command `m=
enu advertise` in bluetoothctl. If the error "Failed to register advertisem=
ent: org.bluez.Error.Failed" is received then check /var/log/syslog for the=
 specific error such as "Advertising data too long or couldn't be generated=
.". Assuming bluetoothd has the -v option set.
> +
> +Advertise Options Commands
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Advertising packets are structured data which is broadcast on the LE Adv=
ertising
> +channels and available for all devices in range.  Because of the limited=
 space
> +available in LE Advertising packets (31 bytes), each packet's contents m=
ust be
> +carefully controlled.
> +
> +This is a long form description of the commands that includes examples. =
Values can either be hexadecimal (0x0C)
> +decimal (12) or octal if  a leading zero (07). Footnotes are indicated b=
y {x} and can be found at the bottom of the page.
> +
> +
> +uuids
> +-----
> +Set/Get advertise uuids
> +  The assumed format of the uuid is hex. Therefore uuids 0x1234 identica=
l to uuids 1234.
> +  The valid uuids are:
> +  - 16 bit uuids - ex: uuids 0x1234
> +  - 32 bit uuids - ex: uuids 0x12345678
> +  - 128 bit uuids - ex: uuids 90f95193-35de-4306-a6e9-699328f15059
> +
> +    .. note:: 128 bit uuids must be in the format xxxxxxxx-xxxx-xxxx-xxx=
x-xxxxxxxxxxxx where x is a hexadecimal digit and the dashes are included.
> +
> +:Usage: **# uuids [all/uuid1 uuid2 ...]**
> +
> +service
> +-------
> +Set/Get advertise service data
> +
> +:Usage: **# service [uuid] [data=3Dxx xx ...]**
> +
> +manufacturer
> +------------
> +Set/Get advertise manufacturer data
> +  updating is in real time while advertising. This is currently limited =
to 25 bytes and will return an error message of "Too much data"
> +  if that maximum has been exceeded. However, this does not check if the=
 advertising payload length maximum has been exceeded so you
> +  may receive an error from bluetoothd that it "Failed to register adver=
tisement" which means you need to reduce your manufacturer data length.
> +
> +:Usage: **# manufacturer [id] [data=3Dxx xx ...]**
> +
> +data
> +----
> +Set/Get advertise data
> +  This allows you to advertise data with a given type. You cannot use a =
registered data type value {1} with
> +  this command. For LE the advertising shows up in the primary advertise=
ments
> +  Example: Advertises a nonregistered data type of 0x0C with three octet=
s of data (01 0x0F 13)::
> +
> +    data 0x0C 01 0x0F 13
> +
> +  If you set only the type of the data without any data (data 0x0c) this=
 will cause a parse error when turning advertise on.
> +  You can only send a maximum of 8 bytes of data. data 0x0c 00 01 02 03 =
04 05 06 07
> +  You can modify the advertising data while it is advertising
> +  To get the currently set data use the command data without any argumen=
ts
> +  To delete the currently set data you need to...   (clear does not appe=
ar to work)
> +
> +:Usage: **# data [type] [data=3Dxx xx ...]**
> +
> +discoverable
> +------------
> +Set/Get advertise discoverable
> +  For LE discoverable on will set the LE General Discoverable Mode flag =
to true in the primary advertisement if on.
> +  This feature can be changed during advertising, but will only trigger =
LE General Discoverable Mode even if you had previously selected
> +  discoverable-timeout this will be ignored.
> +  Entering the command by itself will show the status of the setting
> +
> +:Usage: **# discoverable [on/off]**
> +
> +discoverable-timeout
> +--------------------
> +Set/Get advertise discoverable timeout
> +  Using this feature in LE will cause the LE Limited Discoverable Mode f=
lag to be set in the primary advertisement and
> +  The LE General Discoverable Mode flag will not be set. The LE Limited =
Discoverable Mode flag will automatically turn off after [seconds]
> +  discoverable [on] must be set to use this feature
> +  Entering the command by itself will show the time value
> +
> +:Usage: **# discoverable-timeout [seconds]**
> +
> +tx-power
> +--------
> +Show/Enable/Disable TX power to be advertised
> +  This sets the TX Power Level field in the advertising packet. The valu=
e is in dBm and can be between -127 and 127.
> +  Entering the command by itself will show the current value
> +  When this feature is turned on the LE device will advertise its transm=
it power in the primary advertisement
> +  This feature can be modified while advertising.
> +  Entering the command by itself will show the status of the setting
> +
> +:Usage: **# tx-power [on/off] [power]**
> +
> +name
> +----
> +Configure local name to be advertised
> +  Local name to be used in the advertising report. If the string is too =
big to fit into the packet it will be truncated.
> +  It will either advertise as a complete local name or if it has to be t=
runcated then a shortened local name
> +  advertise.name "0123456789abcdef0123456789abcdef"
> +  Text: 0123456789abcdef0123456789abc
> +  There does not appear to be a way to tell if it is advertising with a =
complete or shortened local name.
> +
> +:Usage: **# name [on/off/name]**
> +
> +appearance
> +----------
> +Configure custom appearance to be advertised
> +
> +:Usage: **# appearance [on/off/value]**
> +
> +duration
> +--------
> +Set/Get advertise duration
> +  The Duration parameter configures the length of an Instance. The value=
 is in seconds.
> +  A value of 0 indicates a default value is chosen for the Duration. The=
 default is 2 seconds.
> +  If only one advertising Instance has been added, then the Duration val=
ue will be ignored.
> +  If multiple advertising Instances have been added, then the Duration v=
alue will be used to determine the length of time
> +  each Instance is advertised for. The Duration value is used to calcula=
te the number of advertising events that will be
> +  used to advertise each Instance. The number of advertising events is c=
alculated by dividing the Duration value by the
> +  advertising interval. The advertising interval is determined by the ad=
vertising parameters that are set for each
> +  Instance. The advertising interval is the maximum of the advertising i=
ntervals set for each Instance.
> +  The Duration value is used to calculate the number of advertising even=
ts that will be used to advertise each Instance.
> +  The number of advertising events is calculated by dividing the Duratio=
n value by the advertising interval. The advertising
> +  interval is determined by the advertising parameters that are set for =
each Instance. The advertising interval is the maximum
> +  of the advertising intervals set for each Instance.
> +  The Duration value is used to calculate the number of advertising even=
ts that will be used to advertise each Instance.
> +  The number of advertising events is calculated by dividing the Duratio=
n value by the advertising interval. The advertising
> +  interval is determined by the advertising parameters that are set for =
each Instance. The advertising interval is the maximum
> +  of the advertising intervals set for each Instance.
> +  The Duration value is used to calculate the number of advertising even=
ts that will be used to advertise each Instance.
> +  The number of advertising events is calculated by dividing the Duratio=
n value by the advertising interval. The advertising
> +  interval is determined by the advertising parameters that are set for =
each Instance. The advertising interval is the maximum
> +  of the advertising intervals set for each Instance.
> +  The Duration value is used to calculate the number of advertising even=
ts that will be used to advertise each Instance.
> +  The number of advertising events is calculated by dividing the Duratio=
n value by the advertising interval. The advertising
> +  interval is determined by the advertising parameters that are set for =
each Instance. The advertising interval is the maximum
> +  of the advertising intervals set for each Instance.
> +  The Duration value is used to calculate the number of advertising even=
ts that will be used to advertise each Instance.
> +  The number of advertising events is
> +  calculated by dividing the Duration value by the advertising interval.=
 The advertising interval is determined by the
> +  advertising parameters that are set for each Instance. The advertising=
 interval is the maximum of the advertising intervals
> +  set for each Instance.
> +
> +:Usage: **# duration [seconds]**
> +
> +timeout
> +-------
> +  Set/Get advertise timeout
> +
> +:Usage: **# timeout [seconds]**
> +
> +secondary
> +---------
> +  Set/Get advertise secondary channel
> +  The Secondary parameter configures the secondary channel used for adve=
rtising.
> +
> +:Usage: **# secondary [1M/2M/Coded]**
> +
> +interval
> +--------
> +Set/Get advertise interval
> +  The Interval parameter configures the advertising interval of an Insta=
nce. The value is in milliseconds.
> +  A value of 0 indicates a default value is chosen for the Interval. The=
 default is 100 milliseconds.
> +  The Interval value is used to calculate the number of advertising even=
ts that will be used to advertise each Instance.
> +  The number of advertising events is calculated by dividing the Duratio=
n value by the advertising interval. The advertising
> +  interval is determined by the advertising parameters that are set for =
each Instance. The advertising interval is the maximum
> +  of the advertising intervals set for each Instance.
> +
> +:Usage: **# interval [milliseconds]**
> +
> +clear
> +-----
> +Clear advertise config
> +  Clear the advertise configuration. This will stop advertising if it is=
 currently advertising.
> +  If you want to change the advertise configuration while advertising yo=
u must first clear the advertise configuration
> +  and then set the new advertise configuration.
> +
> +:Usage: **# clear [uuids/service/manufacturer/config-name...]**
> +
> +back
> +----
> +Return to main menu
> +
> +:Usage: **# back**
> +
> +version
> +-------
> +Display version
> +
> +:Usage: **# version**
> +
> +quit
> +----
> +Quit program
> +
> +:Usage: **# quit**
> +
> +exit
> +----
> +Quit program
> +
> +:Usage: **# exit**
> +
> +help
> +----
> +Display help about this program
> +
> +:Usage: **# help**
> +
> +export
> +------
> +Print environment variables
> +
> +:Usage: **# export**
> +
> +NOTES
> +=3D=3D=3D=3D=3D
> +A byte is defined as an octet
> +{1}  `Generic Access Profile Assigned Numbers document <https://btprodsp=
ecificationrefs.blob.core.windows.net/assigned-numbers/Assigned%20Number%20=
Types/Generic%20Access%20Profile.pdf>`
> +
> +RESOURCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +linux-bluetooth@vger.kernel.org
> diff --git a/client/bluetoothctl-endpoint.rst b/client/bluetoothctl-endpo=
int.rst
> new file mode 100644
> index 000000000..95f981326
> --- /dev/null
> +++ b/client/bluetoothctl-endpoint.rst
> @@ -0,0 +1,121 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +bluetoothctl
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +----------------
> +Endpoint Submenu
> +----------------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under ther terms of the=
 GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: November 2022
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl** [**-a** *capability*] [**-e**] [**-m**] [**-t** *second=
s*] [**-v**] [**-h**]
> +
> +DESCRIPTION
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl(1)** interactive bluetooth control tool. The tool works w=
ith Bluetooth Classic (BR/EDR) and Bluetooth Low Energy (LE) controllers.
> +
> +OPTIONS
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +-a capability, --agent capability        Register agent handler: <capabi=
lity>
> +-e, --endpoints                  Register Media endpoints
> +-m, --monitor                    Enable monitor output
> +-t seconds, --timeout seconds    Timeout in seconds for non-interactive =
mode
> +-v, --version       Display version
> +-h, --help          Display help
> +
> +Endpoint Commands
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   We divide bluetoothctl into main menu commands and submenu commands. =
The submenu commands control options
> +   numbers for the commands can be hex (0x0F) or decimal (10)
> +
> +list
> +----
> +List available endpoints
> +
> +:Usage: **# list [local]**
> +
> +show
> +----
> +Endpoint information
> +
> +:Usage: **# show <endpoint>**
> +
> +register
> +--------
> +Register Endpoint
> +
> +:Usage: **# register <UUID> <codec> [capabilities...]**
> +
> +unregister
> +----------
> +Register Endpoint
> +
> +:Usage: **# unregister <UUID/object>**
> +
> +config
> +------
> +Configure Endpoint
> +
> +:Usage: **# config <endpoint> <local endpoint> [preset]**
> +
> +presets
> +-------
> +List available presets
> +
> +:Usage: **# presets <UUID> [default]**
> +
> +back
> +----
> +Return to main menu
> +
> +:Usage: **# back**
> +
> +version
> +-------
> +Display version
> +
> +:Usage: **# version**
> +
> +quit
> +----
> +Quit program
> +
> +:Usage: **# quit**
> +
> +exit
> +----
> +Quit program
> +
> +:Usage: **# exit**
> +
> +help
> +----
> +Display help about this program
> +
> +:Usage: **# help**
> +
> +export
> +------
> +Print environment variables
> +
> +:Usage: **# export**
> +
> +RESOURCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +linux-bluetooth@vger.kernel.org
> diff --git a/client/bluetoothctl-gatt.rst b/client/bluetoothctl-gatt.rst
> new file mode 100644
> index 000000000..346e7f388
> --- /dev/null
> +++ b/client/bluetoothctl-gatt.rst
> @@ -0,0 +1,212 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +bluetoothctl
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +-------------------------
> +Generic Attribute Submenu
> +-------------------------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under ther terms of the=
 GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: November 2022
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl** [**-a** *capability*] [**-e**] [**-m**] [**-t** *second=
s*] [**-v**] [**-h**]
> +
> +OPTIONS
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +-a capability, --agent capability        Register agent handler: <capabi=
lity>
> +-e, --endpoints                  Register Media endpoints
> +-m, --monitor                    Enable monitor output
> +-t seconds, --timeout seconds    Timeout in seconds for non-interactive =
mode
> +-v, --version       Display version
> +-h, --help          Display help
> +
> +COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +   We divide bluetoothctl into main menu commands and submenu commands. =
The submenu commands control options
> +   numbers for the commands can be hex (0x0F) or decimal (10)
> +
> +
> +
> +Generic Attribute Commands
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +list-attributes
> +---------------
> +List attributes
> +
> +:Usage: **# list-attributes <attribute/UUID>**
> +
> +select-attribute
> +----------------
> +Select attribute
> +
> +:Usage: **# select-attribute <attribute/UUID>**
> +
> +attribute-info
> +--------------
> +Select attribute
> +
> +:Usage: **# attribute-info [attribute/UUID]**
> +
> +read
> +----
> +Read attribute value
> +
> +:Usage: **# read [offset]**
> +
> +write
> +-----
> +Write attribute value
> +
> +:Usage: **# write <data=3Dxx xx ...> [offset] [type]**
> +
> +acquire-write
> +-------------
> +Acquire Write file descriptor
> +
> +:Usage: **# acquire-write**
> +
> +release-write
> +-------------
> +Release Write file descriptor
> +
> +:Usage: **# release-write**
> +
> +acquire-notify
> +--------------
> +Acquire Notify file descriptor
> +
> +:Usage: **# acquire-notify**
> +
> +release-notify
> +--------------
> +Release Notify file descriptor
> +
> +:Usage: **# release-notify**
> +
> +notify
> +------
> +Notify attribute value
> +
> +:Usage: **# notify <on/off>**
> +
> +clone
> +-----
> +Clone a device or attribute
> +
> +:Usage: **# clone [dev/attribute/UUID]**
> +
> +register-application
> +--------------------
> +Register profile to connect
> +
> +:Usage: **# register-application [UUID ...]**
> +
> +unregister-application
> +----------------------
> +Unregister profile
> +
> +:Usage: **# unregister-application**
> +
> +register-service
> +----------------
> +Register application service.
> +
> +:Usage: **# register-service <UUID> [handle]**
> +
> +unregister-service
> +------------------
> +Unregister application service
> +
> +:Usage: **# unregister-service <UUID/object>**
> +
> +register-includes
> +-----------------
> +Register as Included service in.
> +
> +:Usage: **#r egister-includes <UUID> [handle]**
> +
> +unregister-includes
> +-------------------
> +Unregister Included service.
> +
> +:Usage: **# unregister-includes <Service-UUID><Inc-UUID>**
> +
> +register-characteristic
> +-----------------------
> +Register application characteristic
> +
> +:Usage: **# register-characteristic <UUID> <Flags=3Dread,write,notify...=
> [handle]**
> +
> +unregister-characteristic
> +-------------------------
> +Unregister application characteristic
> +
> +:Usage: **# unregister-characteristic <UUID/object>**
> +
> +register-descriptor
> +-------------------
> +Register application descriptor
> +
> +:Usage: **# register-descriptor <UUID> <Flags=3Dread,write...> [handle]*=
*
> +
> +unregister-descriptor
> +---------------------
> +Unregister application descriptor
> +
> +:Usage: **# unregister-descriptor <UUID/object>**
> +
> +back
> +----
> +Return to main menu
> +
> +:Usage: **# back**
> +
> +version
> +-------
> +Display version
> +
> +:Usage: **# version**
> +
> +quit
> +----
> +Quit program
> +
> +:Usage: **# quit**
> +
> +exit
> +----
> +Quit program
> +
> +:Usage: **# exit**
> +
> +help
> +----
> +Display help about this program
> +
> +:Usage: **# help**
> +
> +export
> +------
> +Print environment variables
> +
> +:Usage: **# export**
> +
> +
> +RESOURCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +linux-bluetooth@vger.kernel.org
> diff --git a/client/bluetoothctl-player.rst b/client/bluetoothctl-player.=
rst
> new file mode 100644
> index 000000000..96960c45b
> --- /dev/null
> +++ b/client/bluetoothctl-player.rst
> @@ -0,0 +1,200 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +bluetoothctl-player
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +--------------------
> +Media Player Submenu
> +--------------------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under ther terms of the=
 GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: November 2022
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl** [**-a** *capability*] [**-e**] [**-m**] [**-t** *second=
s*] [**-v**] [**-h**]
> +
> +DESCRIPTION
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl(1)** interactive bluetooth control tool. The tool works w=
ith Bluetooth Classic (BR/EDR) and Bluetooth Low Energy (LE) controllers.
> +
> +OPTIONS
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +-a capability, --agent capability        Register agent handler: <capabi=
lity>
> +-e, --endpoints                  Register Media endpoints
> +-m, --monitor                    Enable monitor output
> +-t seconds, --timeout seconds    Timeout in seconds for non-interactive =
mode
> +-v, --version       Display version
> +-h, --help          Display help
> +
> +Media Player Commands
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   We divide bluetoothctl into main menu commands and submenu commands. =
The submenu commands control options
> +   numbers for the commands can be hex (0x0F) or decimal (10)
> +
> +list
> +----
> +List available players
> +
> +:Usage: **# list**
> +
> +show
> +----
> +Show player information
> +
> +:Usage: **# show [player]**
> +
> +select
> +------
> +Select default player
> +
> +:Usage: **# select <player>**
> +
> +play
> +----
> +Start playback
> +
> +:Usage: **# play [item]**
> +
> +pause
> +-----
> +Pause playback
> +
> +:Usage: **# pause**
> +
> +stop
> +----
> +Stop playback
> +
> +:Usage: **# stop**
> +
> +next
> +----
> +Jump to next item
> +
> +:Usage: **# next**
> +
> +previous
> +--------
> +Jump to previous item
> +
> +:Usage: **# previous**
> +
> +fast-forward
> +------------
> +Fast forward playback
> +
> +:Usage: **# fast-forward**
> +
> +rewind
> +------
> +Rewind playback
> +
> +:Usage: **# rewind**
> +
> +equalizer
> +---------
> +Enable/Disable equalizer
> +
> +:Usage: **# equalizer <on/off>**
> +
> +repeat
> +------
> +Set repeat mode
> +
> +:Usage: **# repeat <singletrack/alltrack/group/off>**
> +
> +shuffle
> +-------
> +Set shuffle mode
> +
> +:Usage: **# shuffle <alltracks/group/off>**
> +
> +scan
> +----
> +Set scan mode
> +
> +:Usage: **# scan <alltracks/group/off>**
> +
> +change-folder
> +-------------
> +Change current folder
> +
> +:Usage: **# change-folder <item>**
> +
> +list-items
> +----------
> +List items of current folder
> +
> +:Usage: **# list-items [start] [end]**
> +
> +search
> +------
> +Search items containing string
> +
> +:Usage: **# search <string>**
> +
> +queue
> +-----
> +Add item to playlist queue
> +
> +:Usage: **# queue <item>**
> +
> +show-item
> +---------
> +Show item information
> +
> +:Usage: **# show-item <item>**
> +
> +back
> +----
> +Return to main menu
> +
> +:Usage: **# back**
> +
> +version
> +-------
> +Display version
> +
> +:Usage: **# version**
> +
> +quit
> +----
> +Quit program
> +
> +:Usage: **# quit**
> +
> +exit
> +----
> +Quit program
> +
> +:Usage: **# exit**
> +
> +help
> +----
> +Display help about this program
> +
> +:Usage: **# help**
> +
> +export
> +------
> +Print environment variables
> +
> +:Usage: **# export**
> +
> +
> +RESOURCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +linux-bluetooth@vger.kernel.org
> diff --git a/client/bluetoothctl-scan.rst b/client/bluetoothctl-scan.rst
> new file mode 100644
> index 000000000..4bd06595d
> --- /dev/null
> +++ b/client/bluetoothctl-scan.rst
> @@ -0,0 +1,146 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +bluetoothctl-scan
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +------------
> +Scan Submenu
> +------------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under ther terms of the=
 GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: July 2023
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl** [**-a** *capability*] [**-e**] [**-m**] [**-t** *second=
s*] [**-v**] [**-h**] [scan.commands]
> +
> +OPTIONS
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +-a capability, --agent capability        Register agent handler: <capabi=
lity>
> +-e, --endpoints                  Register Media endpoints
> +-m, --monitor                    Enable monitor output
> +-t seconds, --timeout seconds    Timeout in seconds for non-interactive =
mode
> +-v, --version       Display version
> +-h, --help          Display help
> +
> +Scan Commands
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   The scan commands control options numbers for the commands can be hex=
 (0x0F) or decimal (10)
> +
> +uuids
> +-----
> +Set/Get UUIDs filter
> +
> +:Usage: **# uuids [all/uuid1 uuid2 ...]**
> +
> +rssi
> +----
> +Set/Get RSSI filter, and clears pathloss
> +This sets the minimum rssi value for reporting device advertisements. Th=
e value is in dBm.
> +Example: To only show devices with rssi values greater than or equal to =
-60 dBm, use `scan.rssi -60`.
> +If one or more discovery filters have been set, the RSSI delta-threshold=
 imposed by starting discovery by default will not be applied.
> +
> +:Usage: **# rssi [rssi]**
> +
> +pathloss
> +--------
> +Set/Get Pathloss filter, and clears RSSI
> +This sets the maximum pathloss value for reporting device advertisements=
. The value is in dB.
> +Example: To only show devices with pathloss values less than or equal to=
 4 dB, use `scan.pathloss 4`.
> +If one or more discovery filters have been set, the RSSI delta-threshold=
 imposed by starting discovery by default will not be applied.
> +
> +:Usage: **# pathloss [pathloss]**
> +
> +transport
> +---------
> +Set/Get transport filter
> +Transport parameter determines the type of scan. The default is auto.
> +
> +Possible values:
> +
> +- "auto": interleaved scan
> +- "bredr": BR/EDR inquiry
> +- "le": LE scan only
> +
> +If "le" or "bredr" Transport is requested and the controller doesn't sup=
port it, an org.bluez.Error.Failed error will be returned. If "auto" transp=
ort is requested, the scan will use LE, BREDR, or both, depending on what's=
 currently enabled on the controller.
> +
> +duplicate-data
> +--------------
> +Set/Get duplicate data filter
> +Disables duplicate detection of advertisement data. When enabled, Proper=
tiesChanged signals will be generated for ManufacturerData and ServiceData =
every time they are discovered.
> +
> +:Usage: **# duplicate-data [on/off]**
> +
> +discoverable
> +------------
> +Set/Get discoverable filter
> +Makes the adapter discoverable while discovering. If the adapter is alre=
ady discoverable, setting this filter won't have any effect.
> +
> +:Usage: **# discoverable [on/off]**
> +
> +pattern
> +-------
> +Set/Get pattern filter
> +Discover devices where the pattern matches either the prefix of the addr=
ess or the device name, which is a convenient way to limit the number of de=
vice objects created during a discovery.
> +When set, it disregards device discoverable flags.
> +Note: The pattern matching is ignored if there are other clients that do=
n't set any pattern, as it works as a logical OR. Also, setting an empty st=
ring "" pattern will match any device found.
> +
> +:Usage: **# pattern [value]**
> +
> +
> +clear
> +-----
> +Clears discovery filter
> +
> +:Usage: **# clear [uuids/rssi/pathloss/transport/duplicate-data/discover=
able/pattern]**
> +
> +back
> +----
> +Return to the main menu
> +
> +:Usage: **# back**
> +
> +version
> +-------
> +Display version
> +
> +:Usage: **# version**
> +
> +quit
> +----
> +Quit program
> +
> +:Usage: **# quit**
> +
> +exit
> +----
> +Quit program
> +
> +:Usage: **# exit**
> +
> +help
> +----
> +Display help about this program
> +
> +:Usage: **# help**
> +
> +export
> +------
> +Print environment variables
> +
> +:Usage: **# export**
> +
> +RESOURCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +linux-bluetooth@vger.kernel.org
> diff --git a/client/bluetoothctl-transport.rst b/client/bluetoothctl-tran=
sport.rst
> new file mode 100644
> index 000000000..3dd4d4a75
> --- /dev/null
> +++ b/client/bluetoothctl-transport.rst
> @@ -0,0 +1,128 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +bluetoothctl
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +-----------------------
> +Media Transport Submenu
> +-----------------------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under ther terms of the=
 GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: November 2022
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl** [**-a** *capability*] [**-e**] [**-m**] [**-t** *second=
s*] [**-v**] [**-h**]
> +
> +DESCRIPTION
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl(1)** interactive bluetooth control tool. The tool works w=
ith Bluetooth Classic (BR/EDR) and Bluetooth Low Energy (LE) controllers.
> +
> +OPTIONS
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +-a capability, --agent capability        Register agent handler: <capabi=
lity>
> +-e, --endpoints                  Register Media endpoints
> +-m, --monitor                    Enable monitor output
> +-t seconds, --timeout seconds    Timeout in seconds for non-interactive =
mode
> +-v, --version       Display version
> +-h, --help          Display help
> +
> +Media Transport Commands
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +   We divide bluetoothctl into main menu commands and submenu commands. =
The submenu commands control options
> +   numbers for the commands can be hex (0x0F) or decimal (10)
> +
> +list
> +----
> +List available transports
> +
> +:Usage: **# list**
> +
> +show
> +----
> +Show transport information
> +
> +:Usage: **# show <transport>**
> +
> +acquire
> +-------
> +Acquire transport
> +
> +:Usage: **# acquire <transport> [transport1...]**
> +
> +release
> +-------
> +Release transport
> +
> +:Usage: **# release <transport> [transport1...]**
> +
> +send
> +----
> +Send contents of a file
> +
> +:Usage: **# send <transport> <filename>**
> +
> +receive
> +-------
> +Get/Set file to receive
> +
> +:Usage: **# receive <transport> [filename]**
> +
> +volume
> +------
> +Get/Set transport volume
> +
> +:Usage: **# volume <transport> [value]**
> +
> +back
> +----
> +Return to main menu
> +
> +:Usage: **# back**
> +
> +version
> +-------
> +Display version
> +
> +:Usage: **# version**
> +
> +quit
> +----
> +Quit program
> +
> +:Usage: **# quit**
> +
> +exit
> +----
> +Quit program
> +
> +:Usage: **# exit**
> +
> +help
> +----
> +Display help about this program
> +
> +:Usage: **# help**
> +
> +export
> +------
> +Print environment variables
> +
> +:Usage: **# export**
> +
> +
> +RESOURCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +linux-bluetooth@vger.kernel.org
> diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
> new file mode 100644
> index 000000000..c7ceb093a
> --- /dev/null
> +++ b/client/bluetoothctl.rst
> @@ -0,0 +1,366 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +bluetoothctl
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +------------------------------------
> +interactive bluetooth control tool
> +------------------------------------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under ther terms of the=
 GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: November 2022
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl** [**-a** *capability*] [**-e**] [**-m**] [**-t** *second=
s*] [**-v**] [**-h**]
> +
> +DESCRIPTION
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl(1)** interactive bluetooth control tool. The tool works w=
ith Bluetooth Classic (BR/EDR) and Bluetooth Low Energy (LE) controllers.
> +The tool is menu driven but can be automated from the command line. Exam=
ples are given in the automation section.
> +
> +OPTIONS
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +-a capability, --agent capability        Register agent handler: <capabi=
lity>
> +-e, --endpoints                  Register Media endpoints
> +-m, --monitor                    Enable monitor output
> +-t seconds, --timeout seconds    Timeout in seconds for non-interactive =
mode
> +-v, --version       Display version
> +-h, --help          Display help
> +
> +COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +   We divide bluetoothctl into main menu commands and submenu commands. =
The submenu commands can be found at their own pages which are listed below=
.
> +   Submenu items can either be accessed with the menu option i.e. 'menu =
advertise' or directly from the main menu with dot notation i.e. 'advertise=
.tx-power on'
> +
> +
> +MAIN MENU COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +menu advertise
> +--------------
> +Advertise Options Submenu
> +
> +:Usage: **# menu advertise**
> +
> +menu monitor
> +------------
> +Advertisement Monitor Options Submenu
> +
> +:Usage: **# menu monitor**
> +
> +menu scan
> +---------
> +Scan Options Submenu
> +
> +:Usage: **# menu scan**
> +
> +menu gatt
> +---------
> +Generic Attribute Submenu
> +
> +:Usage: **# menu gatt**
> +
> +menu admin
> +----------
> +Admin Policy Submenu
> +
> +:Usage: **# menu admin**
> +
> +menu player
> +-----------
> +Media Player Submenu
> +
> +:Usage: **# menu player**
> +
> +menu endpoint
> +-------------
> +Media Endpoint Submenu
> +
> +:Usage: **# menu endpoint**
> +
> +menu transport
> +--------------
> +Media Transport Submenu
> +
> +:Usage: **# menu transport**
> +
> +list
> +----
> +List available controllers
> +
> +:Usage: **# list**
> +
> +show
> +----
> +Controller information
> +
> +:Usage: **# show [ctrl]**
> +
> +select
> +------
> +Select default controller
> +
> +:Usage: **# select <ctrl>**
> +
> +devices
> +-------
> +List available devices, with an optional property as the filter
> +
> +:Usage: **# devices [Paired/Bonded/Trusted/Connected]**
> +
> +system-alias
> +------------
> +Set controller alias
> +
> +:Usage: **# system-alias <name>**
> +
> +reset-alias
> +-----------
> +Reset controller alias
> +
> +:Usage: **# reset-alias**
> +
> +power
> +-----
> +Set controller power
> +When the controller is powered off, the USB port the controller is attac=
hed to is put into a suspend state. When the controller is powered on the p=
ort is taken out of a suspend state and the controller is power cycled. Any=
 firmware will be reloaded at this time.
> +
> +:Usage: **# power <on/off>**
> +
> +advertise
> +---------
> +Enable/disable advertising with given type
> +Will start advertising. If you exit the program advertising will be disa=
bled. When advertising the controller should advertise with random address =
but may use its public address if it does not support the feature (address =
of the device)
> +A device can advertise if it initiated the connection to another adverti=
sing device.
> +When advertising the controller will always advertise with the connectab=
le option.
> +
> +:Usage: **# advertise <on/off/type>**
> +
> +set-alias
> +---------
> +Set device alias
> +
> +:Usage: **# set-alias <alias>**
> +
> +scan
> +----
> +Scan for devices
> +  For LE, scanning is an important requirement before connecting or pair=
ing. The purpose of scanning is to find devices
> +  that are advertising with their discoverable flag set (either limited =
or general). Once you have found the address
> +  then you can connect or pair. Note the following when scanning:
> +
> +  - When scanning the controller will use a random address that is not r=
esolvable. A new random address is created every time scan on is used.
> +  - When turning on scanning the device will start receiving advertising=
 reports of what devices are advertising.
> +  - The filtering of duplicate advertising reports is enabled.
> +  - The scan interval and scan window are fixed at 11.250 msec.
> +  - You do get advertising reports from nondiscoverable devices.
> +  - Scan reports have a finite time duration and will expire. If they ex=
pire you will need to scan again before connecting or pairing.
> +
> +:Usage: **# scan <on/off/bredr/le>**
> +
> +pair
> +----
> +Pair with device
> +This will pair with a device and then trust and connect to it. If the de=
vice is already paired this will first remove the pairing.
> +Pairing provides authentication or encryption. The command can either be=
 used while the controller is in the connected or not connected state.
> +If the controller is already connected then the pair command can be used=
 without an arguments. If the controller is not connected, the pair
> +command can be given the address of a device with an active scan report =
and it will initiate the connection before pairing.
> +Before pairing the agent must be selected to choose the authentication m=
echanism.
> +
> +:Usage: **# pair <dev>**
> +
> +pairable
> +--------
> +Set controller pairable mode
> +This enables/disables pairing. If pairing is disabled then the controlle=
r will not accept any pairing requests.
> +
> +:Usage: **# pairable <on/off>**
> +
> +discoverable
> +------------
> +Set discoverable mode
> +This enables/disables discoverable mode. If discoverable is disabled the=
n the controller will not respond to any scan requests.
> +In LE if discoverable if off the controller will just passively scan and=
 not make scan requests to advertising devices. If on it will make the adve=
rtising requests.
> +It will use a random address if supported by the controller. The length =
of time "discoverable on" is valid is determined by discoverable-timeout
> +
> +:Usage: **# discoverable <on/off>**
> +
> +discoverable-timeout
> +--------------------
> +Set discoverable timeout
> +The time in seconds that "discoverable on" is valid.
> +
> +:Usage: **# discoverable-timeout [value]**
> +
> +agent
> +-----
> +Enable/disable agent with given capability
> +This chooses the local authentication mechanism of the controller. It is=
 needed for pairing and allows you to choose the IO capabilities of the con=
troller.
> +The valid agent capabilities are: DisplayOnly, DisplayYesNo, KeyboardDis=
play, KeyboardOnly, NoInputNoOutput.
> +
> +:Usage: **# agent <on/off/capability>**
> +
> +default-agent
> +-------------
> +Set agent as the default one
> +After selecting the agent this will make it the default agent
> +
> +:Usage: **# default-agent**
> +
> +trust
> +-----
> +Trust device
> +
> +:Usage: **# trust <dev>**
> +
> +untrust
> +-------
> +Untrust device
> +
> +:Usage: **# untrust <dev>**
> +
> +block
> +-----
> +Block device
> +
> +:Usage: **# block <dev>**
> +
> +unblock
> +-------
> +Unblock device
> +
> +:Usage: **# unblock <dev>**
> +
> +remove
> +------
> +Remove device
> +
> +:Usage: **# remove <dev>**
> +
> +connect
> +-------
> +Connect device
> +This will initiate a connection to a device. If the device is not paired=
 this will first pair and then trust and connect to it.
> +To connect with a device the controller must have an active scan report =
of the device it wants to connect to. The advertising report can be obtaine=
d either by using the scan command
> +otherwise the connect command will issue a HCI_LE_Set_Extended_Scan_Enab=
le to find the device. If no advertising report is received before the time=
out a le-connection-abort-by-local
> +error will be issued. In that case either try again to connect assuming =
the device is advertising.
> +
> +:Usage: **# connect <dev>**
> +
> +disconnect
> +----------
> +Disconnect device
> +For LE when disconnecting from an active connection the device address i=
s not needed.
> +
> +:Usage: **# disconnect <dev>**
> +
> +info
> +----
> +Device information
> +
> +:Usage: **# info <dev>**
> +
> +menu
> +----
> +Menu option
> +This will allow you to access the submenu options directly from the main=
 menu. The submenu options are listed below.
> +
> +:Usage: **# menu <submenu>**
> +
> +version
> +-------
> +Display version
> +
> +:Usage: **# version**
> +
> +quit
> +----
> +Quit program
> +
> +:Usage: **# quit**
> +
> +help
> +----
> +Display help
> +
> +:Usage: **# help**
> +
> +exit
> +----
> +Exit program
> +
> +:Usage: **# exit**
> +
> +export
> +------
> +Print environment variable
> +
> +:Usage: **# export**
> +
> +
> +ADVERTISE OPTIONS SUBMENU COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +See bluetoothctl-advertise
> +
> +ADVERTISEMENT MONITOR OPTIONS SUBMENU COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +See bluetoothctl-monitor
> +
> +SCAN OPTIONS OPTIONS SUBMENU COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +See bluetoothctl-scan
> +
> +GENERIC ATTRIBUTE SUBMENU COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +See bluetoothctl-gatt
> +
> +ADMIN POLICY SUBMENU COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +See bluetoothctl-admin
> +
> +MEDIA PLAYER SUBMENU COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +See bluetoothctl-player
> +
> +MEDIA ENDPOINT SUBMENU COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +See bluetoothctl-endpoint
> +
> +MEDIA TRANSPORT SUBMENU COMMANDS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +See bluetoothctl-transport
> +
> +PAIRING
> +=3D=3D=3D=3D=3D=3D=3D
> +| To pair scanning must first be turned on to get the devices advertisin=
g report.
> +|
> +
> +AUTOMATION
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Two common ways to automate the tool are to use Here Docs or the program=
 expect.
> +Using Here Docs to show information about the Bluetooth controller.
> +
> +.. code:: bash
> +
> +   bluetoothctl <<EOF
> +   list
> +   show
> +   EOF
> +
> +
> +RESOURCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +linux-bluetooth@vger.kernel.org
> --
> 2.30.2
>


--=20
Luiz Augusto von Dentz
