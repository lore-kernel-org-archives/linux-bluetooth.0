Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Add Realtek 8723/8761 support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54F70642BAB21D4498E1AA3EFE3D519A45FC1F15@rsex2.realsil.com.cn>
Date: Fri, 11 Jul 2014 13:19:37 +0200
Cc: Daniel Drake <drake@endlessm.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>
Message-Id: <9E14663D-314D-4C07-9C92-22DE693F5B2A@holtmann.org>
References: <1404218878-14218-1-git-send-email-drake@endlessm.com> <16AC594D-6B3C-4CB6-B951-0763F3E4E27A@holtmann.org> <CAD8Lp45HbA03MycDVu6akTfEET_ZzxrwGpH1TbiQrw5Z178aeA@mail.gmail.com> <53B2D160.4010306@lwfinger.net> <F9E90F3A-5FE4-407C-833A-5E852A260984@holtmann.org> <54F70642BAB21D4498E1AA3EFE3D519A45FBED07@rsex2.realsil.com.cn> <B6A2794A-32D2-4D66-9D61-A27D7DA247B1@holtmann.org> <54F70642BAB21D4498E1AA3EFE3D519A45FBF299@rsex2.realsil.com.cn> <CAD8Lp44-=9RNWf2tfmCL14dWJRiZhGCtj042TprR7Q3m9hbNzA@mail.gmail.com> <54F70642BAB21D4498E1AA3EFE3D519A45FC1E92@rsex2.realsil.com.cn> <CAD8Lp44eaR3yMh6HUtwcMp1HRYBj-ec9+-FvSBJHyFh3WQstDg@mail.gmail.com> <54F70642BAB21D4498E1AA3EFE3D519A45FC1F15@rsex2.realsil.com.cn>
To: =?utf-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Champion,

> 	The setup function is provided in kernel v3.12 , before this version we do not have ways to add in btusb.c and we do not want to change the generic driver too much so we rewrite rtk_btusb.c. 
> 	If the setup function is the way you preferred, we will develop based on generic driver. This seems make btusb.c more complex. We will provide you all the firmware after complete test . If you want to get them before test complete I will send later.

the hdev->setup function is the preferred way since I do not want to duplicate any HCI USB transport logic in any driver.

> 	Most modules can work properly without config file, but some customers may want a special way for example they want to use own bt MAC address rather than the one in modules. The config file provide a flex software way instead of rewrite effuse setting in modules. The config file here is an example and customers may change it if they need. This depend on customer , most notebook products may not need , but smart phone or tablet may use it. I think we cannot cover all the situations and just provide the most common settings.

The case with using an OEM specific BD_ADDR is solved. You just need to add support for hdev->set_bdaddr driver callback and you can modify your Bluetooth public device address. We have a whole set of APIs that just deal with configuring this. The only requirement is that it uses HCI transport.

We also fully integrate chips that have no valid BD_ADDR. Then you just set HCI_QUIRK_INVALID_BDADDR and the kernel keeps the device in unconfigured state until Set Public Address management command is used.

I send details about this to the mailing list. This is tested with chips from Intel and Broadcom in all combinations and works nicely.

Regards

Marcel

