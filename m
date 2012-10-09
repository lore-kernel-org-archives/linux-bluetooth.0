Return-Path: <cyrus@holtmann.org>
Message-ID: <1349799144.27233.100.camel@aeonflux>
Subject: Re: [PATCH 2/9] Pass confirm name as gboolean value
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 09 Oct 2012 18:12:24 +0200
In-Reply-To: <CAMOw1v51MT6AsyCB5X7GVRzbdDsXFJL=Gr5EO9ctJBT=vsBPHA@mail.gmail.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
	 <1349784722-14578-3-git-send-email-szymon.janc@tieto.com>
	 <1349794286.27233.95.camel@aeonflux>
	 <CAMOw1v51MT6AsyCB5X7GVRzbdDsXFJL=Gr5EO9ctJBT=vsBPHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> >> confirm_name is a boolean value and can be pass as such instead of
> >> uint8_t.
> >
> > actually long term I want to move to bool usage. So maybe this is a good
> > start to get this going.
> 
> agreed... on new code that I'm adding I'm using bool.
> 
> Btw, could we already use bool in gdbus/ ?

actually that one is heavily GLib specific. However if you are willing
to also clean up things like guint32, I have no problem with actually
converting that as well.

Getting rid of #include <glib/glib.h> in gdbus.h might be actually nice.

Regards

Marcel


