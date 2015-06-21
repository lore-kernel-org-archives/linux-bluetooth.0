Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
References: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
Date: Sun, 21 Jun 2015 07:25:48 +0100
Message-ID: <CAG_J7JXhGp5JxzFscN1rGsE=QUq4fGv3HZpjMCrK+fariPwZow@mail.gmail.com>
Subject: Re: [PATCH 0/5] sixaxis: Improved support for DualShock 3 clones
From: Laurence Brown <linux-bluetooth@protazoa.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Veseli Veseljko <veseljko75@gmail.com>,
	Alex Gal <a.gal@miip.ca>,
	Laurence Brown <linux-bluetooth@protazoa.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have tested this patch with ShanWan controller, seems to be working perfectly

On 15 June 2015 at 19:28, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi,
>
> This is improved version of sixaxis patches. Comparing to RFCv2 this
> doesn't regress with Navigation Controller and DS4.
>
> Sixaxis specific code needs to be left in input code for DS4 support.
>
> If people report that this works for them I'll push those patches.
>
>
> From RFCv2 cover letter:
> Some DualShock3 clones (eg ShanWan) were reported to not provide valid SDP
> record required by HID profile. Due to this those failed to work with
> current BlueZ sixaxis code (ie no input device were created).
>
> This small serie is an attempt to extend DS3 support also with those
> misbehaving clones. Idea is that we can provide fixed SDP recrod for devices
> that use valid PID/VID and skip SDP search.
>
> In this version SDP is kept in sixaxis plugin and provided via
> btd_device_set_record instead of SDP search. Nice addition is that
> sixaxis specific code is no longer needed in input server.
>
> This makes code similar to how original Fedora sixaxis plugin worked
> as suggested in previous review round.
>
> I tested this with genuine DS3 and it seems to work OK. Testing with
> clones is stil required though.
>
>
> Szymon Janc (5):
>   sixaxis: Fix PID for Navigation Controller
>   core/device: Add support for setting SDP record
>   sixaxis: Provide DualShock 3 SDP record while adding new device
>   profiles/input: Remove not needed sixaxis checks
>   sixaxis: Fix multi-line comments style
>
>  Makefile.plugins        |   1 +
>  plugins/sixaxis.c       | 195 ++++++++++++++++++++++++++++++++++++++++++++++--
>  profiles/input/server.c |   8 --
>  src/device.c            |  31 ++++++++
>  src/device.h            |   3 +
>  5 files changed, 224 insertions(+), 14 deletions(-)
>
> --
> 2.1.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
