Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] What endian type is supported by audio device ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050501122209.63346.qmail@web8309.mail.in.yahoo.com>
References: <20050501122209.63346.qmail@web8309.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1114951774.21785.4.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 01 May 2005 14:49:34 +0200

Hi Mayank,

> Don't you think that we should first find out which
> endian type the user's audio device supports ?
> 
> I mean, in the file sbc.c in the following lines
> 
> for (i = 0; i < samples; i++) {
> 	for (ch = 0; ch < priv->frame.channels; ch++) {
> 		int16_t s =
> (int16_t)(priv->frame.pcm_sample[ch][i]);
> 		*ptr++ = (s & 0xff00) >> 8;
> 		*ptr++ = (s & 0x00ff);
> 	}
> }
> 
> Shouldn't we first check out whether the user's audio
> device supports little endian or big endian type ?
> 
> It should be something like below...
> 
> for (i = 0; i < samples; i++) {
> 	for (ch = 0; ch < priv->frame.channels; ch++) {
> 		int16_t s =
> (int16_t)(priv->frame.pcm_sample[ch][i]);
> 		if(BIG_ENDIAN) {
> 			*ptr++ = (s & 0xff00) >> 8;
> 			*ptr++ = (s & 0x00ff);
> 		}
> 		else {
> 			*ptr++ = (s & 0x00ff);
> 			*ptr++ = (s & 0xff00) >> 8;
> 		}
> 	}
> }
> 
> Ofcourse BIG_ENDIAN will be replaced by a function or
> macro which returns the endian type.
> 
> Do you have knowledge of such a function or macro ?
> If yes, please patch sbc.c file for us.
> 
> It will be great for people like me who have spent
> weeks in figuring out why the sound quality is so poor
> while using sbcdec.c
> 
> I use an Intel based machine, which follows
> little-endian format.
> But sbc.c was using big endian format.

actually this has nothing to do with the machine type. It depends on the
endian format of the input PCM stream. So we should add a flags that
tells us about the endian format of the input.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
