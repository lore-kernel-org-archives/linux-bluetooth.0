Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: obexd-0.8 get OBEX_HDR_NAME NULL
Date: Thu, 5 Mar 2009 12:38:57 +0800
Message-ID: <9F2B2656C8747B498D56A7B30FF5EB9FF9DC9D@CNMAIL13.cn.utstarcom.com>
In-Reply-To: <9F2B2656C8747B498D56A7B30FF5EB9FF9DAEF@CNMAIL13.cn.utstarcom.com>
From: "Yao Ye" <yeyao@utstar.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> hi, all :
> 
> I'm using obexd-0.8 and openobex-1.5 on my pxa310 platform. 
> and I want to send files from a mobile phone to the platform.
> 
> but, when i start receive-file agent, it exit quickly, and no 
> files have been received !
> I found that: in obexd-0.8/src/obex.c, line 644, func: 
> check_put, there
> is:
> 
> os->name = g_convert((const gchar *) hd.bs, hlen,
>         "UTF8", "UTF16BE", NULL, NULL, NULL);
> debug("OBEX_HDR_NAME: %s", os->name);

I have found that the function "g_convert" returns NULL. It shows error
as "Conversion from character set 'UTF16BE' to ' UTF8' is not supported.
"

I have installed glib-2.18.3 on my platform, but have not installed
libiconv on my platform.

is it the reason i failured ?
Thanks in advance for any helps.


Best regards
yesir Yao. 
