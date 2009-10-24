Return-Path: <cyrus@holtmann.org>
Message-ID: <4AE2D292.1050709@pardus.org.tr>
Date: Sat, 24 Oct 2009 13:10:26 +0300
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
MIME-Version: 1.0
To: Mario Limonciello <mario_limonciello@dell.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: hid2hci rules breaks standard USB dell mouses
References: <4AE18EA3.50701@pardus.org.tr> <4AE1E1E8.3080902@dell.com>
In-Reply-To: <4AE1E1E8.3080902@dell.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mario Limonciello wrote:
> Don't use the rules and tool in bluez, they're broke.
>
> Use the rules in udev.
>
>   

So why do we still have that broken tool and rules in bluez? Either they
should be in sync with udev or it should be dropped.

Thanks,

