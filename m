Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Feb 2011 09:45:49 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: "pascal@pabr.org" <pascal@pabr.org>, linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
	Marcel Holtmann <marcel@holtmann.org>, Alan Ott <alan@signal11.us>
Subject: Re: hidp_output_raw_report, HID_OUTPUT_REPORT and Sixaxis
In-Reply-To: <20110217151931.d7ee7e29.ospite@studenti.unina.it>
Message-ID: <alpine.LNX.2.00.1102180944590.2160@pobox.suse.cz>
References: <20101130145405.d8142bc3.ospite@studenti.unina.it> <id3cua$12v$2@dough.gmane.org> <20110217151931.d7ee7e29.ospite@studenti.unina.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 17 Feb 2011, Antonio Ospite wrote:

> However, even if my patch gets is, Output reports on the Sixaxis will
> stop working again as soon as someone implements the behavior you are
> suggesting, that is:
>   Feature Report -> SET_REPORT on the Control channel
>   Output Report  -> DATA on the Interrupt channel
> 
> So I am going to submit the hidp_output_raw_report() override in
> hid-sony.c as well, does this sound OK?

That makes sense to me.

Could you please repost all the patches that are currently being discussed 
are flying around in the air?

I feel I haven't been CCed on all of them, so I don't have the complete 
picture.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
