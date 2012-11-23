Return-Path: <cyrus@holtmann.org>
To: Michael Knudsen <michaelknudsendk@gmail.com>
Subject: Re: [PATCH 0/3] mgmt:  read supported codecs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 23 Nov 2012 11:10:36 +0100
From: Kim Schulz <kim@schulz.dk>
Cc: <linux-bluetooth@vger.kernel.org>,
	Michael Knudsen <m.knudsen@samsung.com>
In-Reply-To: <1353588468-28711-1-git-send-email-m.knudsen@samsung.com>
References: <1353588468-28711-1-git-send-email-m.knudsen@samsung.com>
Message-ID: <1fa0fe72a57870c1ac3dbf97e54bca19@server1.devteam.dk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Den 2012-11-22 13:47, Michael Knudsen skrev:
> This implements the user space side of the read codecs command.
>
> Michael Knudsen (3):
>   Bluetooth:  Add HCI Coding Format definitions
>   Bluetooth:  Support the read codecs operation
>   Doco:  List the read codecs operation
>
>  doc/mgmt-api.txt |   20 +++++++++++++++
>  lib/hci.h        |    9 +++++++
>  lib/mgmt.h       |    8 ++++++
>  tools/btmgmt.c   |   74
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 111 insertions(+)



Looks like the codein these patches have some indentation problems 
(mixes tab and spaces).
-- 
Kim Schulz
