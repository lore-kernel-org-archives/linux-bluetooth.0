Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Bastien Nocera <hadess@hadess.net>
To: Daniele Forsi <dforsi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Date: Tue, 07 Jun 2011 11:03:34 +0100
In-Reply-To: <BANLkTi=X16G8JreU68yFZeoqTbLfy5EyNg@mail.gmail.com>
References: <BANLkTi=rVQ+vi+nN_DH+LuyBe4L6xk=hBg@mail.gmail.com>
	 <1307439241-10585-1-git-send-email-hadess@hadess.net>
	 <BANLkTi=X16G8JreU68yFZeoqTbLfy5EyNg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1307441015.2669.153.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2011-06-07 at 11:49 +0200, Daniele Forsi wrote:
> 2011/6/7 Bastien Nocera:
> 
> > diff --git a/src/adapter.c b/src/adapter.c
> 
> > @@ -938,38 +884,29 @@ void adapter_update_local_name(struct btd_adapter *adapter, const char *name)
> 
> > +               int err = adapter_ops->set_name(adapter->dev_id, name);
> > +               if (err < 0)
> > +                       return -err;
> 
> this should be:
> return err;
> else the error isn't detected in the calling code:

Good catch, fixed now.

> > +       err = adapter_update_local_name (adapter, name);
> > +       if (err < 0)
> > +               return btd_error_failed(msg, strerror(-err));
> 


