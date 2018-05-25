Return-Path: <mka@chromium.org>
Date: Fri, 25 May 2018 16:54:33 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/3] Bluetooth: btqca: Add wcn3990 firmware download
 support.
Message-ID: <20180525235433.GC168650@google.com>
References: <1526041263-18795-1-git-send-email-bgodavar@codeaurora.org>
 <1526041263-18795-3-git-send-email-bgodavar@codeaurora.org>
 <20180511174024.GL19594@google.com>
 <7677945035df7442d604b66d7c47e11b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7677945035df7442d604b66d7c47e11b@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 18, 2018 at 08:04:46PM +0530, Balakrishna Godavarthi wrote:

> as i was on vacation i couldn't able to reply to your comments.
> find my comments inline.

Also sorry for my late reply

> On 2018-05-11 23:10, Matthias Kaehlcke wrote:
> > Hi Bala,
> > 
> > On Fri, May 11, 2018 at 05:51:02PM +0530, Balakrishna Godavarthi wrote:
> > > This patch enables the RAM and NV patch download for wcn3990.
> > > 
> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > ---
> > >  drivers/bluetooth/btqca.c | 46
> > > +++++++++++++++++++++++++++++++++++++++++++++-
> > >  drivers/bluetooth/btqca.h | 13 +++++++++++++
> > >  2 files changed, 58 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> > > index 8219816..40c6b4f 100644
> > > --- a/drivers/bluetooth/btqca.c
> > > +++ b/drivers/bluetooth/btqca.c
> > > @@ -27,7 +27,7 @@
> > > 
> > >  #define VERSION "0.1"
> > > 
> > > -static int rome_patch_ver_req(struct hci_dev *hdev, u32
> > > *rome_version)
> > > +int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
> > 
> > If this and other functions aren't really Rome specific they should
> > probably be renamed to qca_...
> > 
> [Bala]:- will update the functions name in separate patch.
> 
> > > +int qca_uart_setup_cherokee(struct hci_dev *hdev, uint8_t baudrate,
> > > +			    u32 *soc_ver)
> > > +{
> > > +	struct rome_config config;
> > > +	int err;
> > > +
> > > +	/* we are using the existing funciton of ROME,
> > > +	 * instead of duplicating the function for wcn3990.
> > > +	 */
> > 
> > The comment isn't quite accurate, the qca_uart_setup_cherokee() calls
> > existing functions, but is essentially a copy of qca_uart_setup_rome().
> > 
> > The main difference is that the patch version is passed as a parameter
> > instead of determining it in the uart setup function. There seems to
> > be no need to pass the version number in, or if you prefer to do it
> > this way, you could change the Rome code to do this.
> > 
> > The other delta is the filename extension of the rampatch file, which
> > is .bin for Rome and .tlv for Cherokee. Is there a good reason to use
> > a different extension? If not just stick to the existing naming
> > scheme, otherwise you could pass the chip type as a parameter and
> > chose the extensions based on that.
> > 
> [Bala]:- as we see the process to setup of BTchip ROME and wcn3990 setup.
>          For Rome:
>          1. change the operating speed to 3.0mbps.
>          2. request the version
>          3. download RAM patch (.bin extestion)
>          4. downlaod NV patch (.bin extersnion)
>          5. Reset ROME
> 
>         steps 2 to 5 are done in the function qca_uart_setup_rome()
> 
>         For WCN3990:
>         1. Set baudrate to 115200.
>         2. request the version
>         3. set baudrate to operating speed.
>         4. download RAM patch (.tlv extestion)
>         5. downlaod NV patch (.bin extersnion)
>         6. Reset wcn3990
> 
>        steps 2 is done in function rome_patch_ver_req(), where as steps 4 to
> 6 qca_uart_setup_cherokee()
> 
>        the big difference is .bin extension for RAM patch is deprecated and
> BTCCHIP vendor will not support .bin for ram patch any more for latest
> chips.
>        so that could be reason we using a separate function
> qca_uart_setup_cherokee(). if i use the same function by passing the chip
> name to decide the file extension.
>        but again unnecessary i have to request the version command to
> BTCHIP.

You could just pass the version as parameter in both cases, Rome and
Cherokee could go through their respective hoops to obtain it before
calling qca_uart_setup().

The different extension and format strings could easily be fixed. I
admit though that the length of the function is on the edge of where
the redundance is an issue, so if Marcel is fine with it I won't inisit.

(slightly off-topic: is qca_uart_setup_xyz() actually the appropriate
name for the function? Admittedly I know little about the platform,
but it seems the most important thing the function does is to load the
two firmware files, which sounds more like qca_setup_xyz() ...)
