Return-Path: <bjorn.andersson@linaro.org>
Date: Mon, 4 Sep 2017 10:57:24 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btqcomsmd: BD address setup
Message-ID: <20170904175724.GB1165@minitux>
References: <1504509480-14082-1-git-send-email-loic.poulain@linaro.org>
 <B03B0FB0-08E0-4031-9E3D-FE2B7BBAF373@holtmann.org>
 <CAMZdPi-R65vBiY66MQhM=JmL_tUiA-2xJudHwJewOmf2a-Uhvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMZdPi-R65vBiY66MQhM=JmL_tUiA-2xJudHwJewOmf2a-Uhvw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon 04 Sep 03:43 PDT 2017, Loic Poulain wrote:
> On 4 September 2017 at 09:39, Marcel Holtmann <marcel@holtmann.org> wrote:
[..]
> > so lets use bdaddr here. And frankly I would really just use bdaddr_t
> > bdaddr here. You have to swap the address anyway since we use
> > local-mac-address.
> >
> > Unless of course we start using local-bd-address as DT property. Remember
> > that even a WiFi address must be different from a Bluetooth address. You
> > can not use the same. So the boot loader needs to understand that this is
> > the Bluetooth address and not the WiFi address.
> >
> 
> Yes the bootloader seems to set the same address as the wlan one but with
> last bit flipped.

This sounds suspicious, I'll follow up with the LK guys to make sure
we're only setting the property if we find a properly provisioned bd
address.

Regards,
Bjorn
