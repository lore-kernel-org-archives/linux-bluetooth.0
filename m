Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54F70642BAB21D4498E1AA3EFE3D519A45FBF299@rsex2.realsil.com.cn>
References: <1404218878-14218-1-git-send-email-drake@endlessm.com>
	<16AC594D-6B3C-4CB6-B951-0763F3E4E27A@holtmann.org>
	<CAD8Lp45HbA03MycDVu6akTfEET_ZzxrwGpH1TbiQrw5Z178aeA@mail.gmail.com>
	<53B2D160.4010306@lwfinger.net>
	<F9E90F3A-5FE4-407C-833A-5E852A260984@holtmann.org>
	<54F70642BAB21D4498E1AA3EFE3D519A45FBED07@rsex2.realsil.com.cn>
	<B6A2794A-32D2-4D66-9D61-A27D7DA247B1@holtmann.org>
	<54F70642BAB21D4498E1AA3EFE3D519A45FBF299@rsex2.realsil.com.cn>
Date: Tue, 8 Jul 2014 08:57:17 +0100
Message-ID: <CAD8Lp44-=9RNWf2tfmCL14dWJRiZhGCtj042TprR7Q3m9hbNzA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYyXSBCbHVldG9vdGg6IGJ0dXNiOiBBZGQgUmVhbHRlaw==?=
	=?UTF-8?B?IDg3MjMvODc2MSBzdXBwb3J0?=
From: Daniel Drake <drake@endlessm.com>
To: =?UTF-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, Larry Finger <Larry.Finger@lwfinger.net>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Champion,

On Fri, Jul 4, 2014 at 11:11 AM, =E9=99=88=E8=89=B3=E8=90=8D <champion_chen=
@realsil.com.cn> wrote:
>          Attached file includes vendor commands of realtek Bluetooth modu=
les in initialize procedure.
>
> And btusb is example of add rtl setup callbacks (not finished)

Thanks a lot for providing this information!

The btusb example you attached also the USB-ID-to-firmware-name lookup
table that Marcel was not so happy about. Instead it reads the version
info from the device and uses that to decide which of the firmware
files to use (e.g. rtl8723a_fw). It can do this because it drops
support for the following "problematic" RTL8761-based devices which
need a special firmware for each variant of the card:

    { 0x818B, 0x8761, "rtl8761aw8192eu_fw", "rtl8761a_config", NULL, 0
}, //Rtl8761Aw + 8192EU
    { 0x8760, 0x8761, "rtl8761au8192ee_fw", "rtl8761a_config", NULL, 0
}, //Rtl8761AU + 8192EE
    { 0xB761, 0x8761, "rtl8761au8192ee_fw", "rtl8761a_config", NULL, 0
}, //Rtl8761AU + 8192EE
    { 0x8761, 0x8761, "rtl8761au8192ee_fw", "rtl8761a_config", NULL, 0
}, //Rtl8761AU + 8192EE for LI
    { 0x8A60, 0x8761, "rtl8761au8812ae_fw", "rtl8761a_config", NULL, 0
}, //Rtl8761AU + 8812AE
(from https://github.com/lwfinger/rtl8723au_bt/blob/new/rtk_btusb.c#L1450 )

If these particular devices are not common then indeed maybe we can
not worry about supporting them for now.

However, your new code also drops usage of the config firmware files
e.g. rtl8723b_config.
Can you explain what these files are for, and if they are safe to
ignore like your new code does?

Your new code references 2 firmware files that we don't have:
rtl8821a_fw and rtl8761a_fw. Please could you send them over, and
confirm that they are redistributable?

Please also confirm that we have the latest versions of the other 2 files:

rtl8723a_fw: 24356 bytes
md5sum b4a329212ab150b88c3c6ff4c42c51d6

rtl8723b_fw: 38976 bytes
md5sum ebf894b7b91cbebce8aeb5ba63c22914

These can be found at https://github.com/lwfinger/rtl8723au_bt/tree/new

Thanks
Daniel
