Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Jul 2014 11:18:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/9] emulator: Extend le advertising function with
 discoverable flag
Message-ID: <20140718081823.GA32577@t440s.lan>
References: <1405585796-12301-1-git-send-email-jakub.tyszkowski@tieto.com>
 <1405585796-12301-7-git-send-email-jakub.tyszkowski@tieto.com>
 <14957256.nJzz9u0Y1o@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14957256.nJzz9u0Y1o@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jul 18, 2014, Szymon Janc wrote:
> > @@ -2080,6 +2083,23 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
> >  	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
> >  							&cp, sizeof(cp));
> >  
> > +	if (disc_type) {
> 
> So this should be called flags since it pass whole flags AD.
> 
> Other option would be to expect whole 31 bytes here. I'm not sure how flexible
> this could be ie. if providing function for adding AD in TLV style and just
> build this to build adv_data here?

I think just calling the parameter "flags" is good enough for now.

Johan
