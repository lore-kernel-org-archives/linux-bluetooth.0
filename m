Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1307439241-10585-1-git-send-email-hadess@hadess.net>
References: <BANLkTi=rVQ+vi+nN_DH+LuyBe4L6xk=hBg@mail.gmail.com>
	<1307439241-10585-1-git-send-email-hadess@hadess.net>
Date: Tue, 7 Jun 2011 11:49:30 +0200
Message-ID: <BANLkTi=X16G8JreU68yFZeoqTbLfy5EyNg@mail.gmail.com>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Daniele Forsi <dforsi@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/6/7 Bastien Nocera:

> diff --git a/src/adapter.c b/src/adapter.c

> @@ -938,38 +884,29 @@ void adapter_update_local_name(struct btd_adapter *adapter, const char *name)

> +               int err = adapter_ops->set_name(adapter->dev_id, name);
> +               if (err < 0)
> +                       return -err;

this should be:
return err;
else the error isn't detected in the calling code:
> +       err = adapter_update_local_name (adapter, name);
> +       if (err < 0)
> +               return btd_error_failed(msg, strerror(-err));

-- 
Daniele Forsi
