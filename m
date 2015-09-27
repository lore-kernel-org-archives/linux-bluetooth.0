Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJPN1uvPyZ+hZ64_0ZXU9wPLuAR-qm06GrRmHTjc9+rgiChYDQ@mail.gmail.com>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
	<CAJPN1uvPyZ+hZ64_0ZXU9wPLuAR-qm06GrRmHTjc9+rgiChYDQ@mail.gmail.com>
Date: Sun, 27 Sep 2015 07:35:20 -0700
Message-ID: <CAKohpo=s9A_M5FphkvmXutWNzxewCimBUv-mK75tO6nrp3-3AA@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of 'global_lock'
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	Intel Linux Wireless <ilw@linux.intel.com>,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<alsa-devel@alsa-project.org>,
	"open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:"
	<linux-usb@vger.kernel.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
	"open list:NETWORKING DRIVERS (WIRELESS)"
	<linux-wireless@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 26 September 2015 at 22:31, Jiri Slaby <jirislaby@gmail.com> wrote:
> But this has to crash whenever the file is read as val's storage is gone at
> that moment already, right?

Yeah, its fixed now in the new version. This was a *really* bad idea :(
