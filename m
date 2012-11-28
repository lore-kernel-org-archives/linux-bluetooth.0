Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Nov 2012 14:50:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Peter Olson <peter.olson@gmail.com>
Subject: Re: [PATCH bluez] wiimote: add Wii-Remote-Plus ID and name detection
Message-ID: <20121128125041.GA995@x220.ger.corp.intel.com>
References: <1350894680-3947-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350894680-3947-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Mon, Oct 22, 2012, David Herrmann wrote:
> The Nintendo Wii Remote Plus uses a new product ID and name. To detect
> them properly, we need to add them to the wiimote-module.
> 
> To avoid an overlong "if" statement, this converts the match-function to
> walk over an array and check all VID/PID pairs and device-names. This
> makes adding new devices much easier.
> ---
> Hi Johan
> 
> I am actually not sure why Nintendo changed the VID/PID for the new revisions of
> the WiimotePlus. I have a WiimotePlus which still uses the old numbers and works
> here quite well. However, I have now got multiple requests from people with the
> new device name and IDs. Unfortunately, I cannot test these so I'd like to have
> a "Tested-by" by Peter (CC'ed) before this is applied.
> 
> Thanks
> David
> 
>  plugins/wiimote.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)

Well, the Tested-by never came, but since the patch looks ok to me I
went ahead and applied it anyway (with a minor fix to use G_N_ELEMENTS()
instead of your custom array length calculation).

Johan
