Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384016658.3880.39.camel@nuvo>
References: <1384016577.3880.36.camel@nuvo>
	<1384016658.3880.39.camel@nuvo>
Date: Mon, 11 Nov 2013 11:32:08 +0200
Message-ID: <CABBYNZKWPY2UMOuexvPMHKpiJJ8efgA_xxWOU1yXV_d6LKy9=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] gdbus: Don't try to remove removed sources
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sat, Nov 9, 2013 at 7:04 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Sat, 2013-11-09 at 18:02 +0100, Bastien Nocera wrote:
>> When we return FALSE from idle handlers, the source is removed.
>> This will be causing warnings in glib 2.40.
>>
>> See https://bugzilla.gnome.org/show_bug.cgi?id=710724
>
> Note that there's plenty of other places where this should be fixed.
> I'll leave those up to somebody who doesn't get RSI ;)

Btw, did you really got a problem or was just by looking at the code?
process_changes always call remove_pending so perhaps the problem was
just in generic_unregister, so the change to process_changes was not
really necessary.

-- 
Luiz Augusto von Dentz
