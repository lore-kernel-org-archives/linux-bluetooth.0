Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 12:47:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/19] Fix D-Bus memory leaks, bluetooth name,
 double unref etc
Message-ID: <20120413094721.GA11639@x220.ger.corp.intel.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Thu, Apr 12, 2012, Syam Sidhardhan wrote:
> This series of patches fixes the following issues.
> 
> Syam Sidhardhan (19):
>   health: Fix memory leak
>   avrcp: Fix the response ctype of SetPlayerApplicationSettingValue
>   agent: Free the agent request properly
>   gstavdtpsink: Fix D-Bus memory leak in audio
>   gateway: Fix D-Bus memory leak in audio
>   gateway: Fix D-Bus reply memory leak
>   hci: Retrieve the bluetooth name correctly
>   hciconfig: Remove unwanted NULL termination
>   agent: Fix double D-Bus message unref
>   sdpd-request: Fix passing zero instead of NULL
>   sap-u8500: Fix empty parameter list in function declaration
>   adapter: Remove headers declared but not defined
>   headset: Remove header declared but not defined
>   network: Remove header declared but not defined
>   audio: Fix newline before EOF
>   input: Fix newline before EOF
>   src: Fix newline before EOF
>   doc: Fix typo
>   Add Syam's email address

Thanks a lot for these cleanups and fixes! I've applied all except the
hci & hciconfig patches regarding the adapter name since those need a
bit of discussing.

Johan
