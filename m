Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <12002429.87611332309390515.JavaMail.weblogic@epml17>
References: <12002429.87611332309390515.JavaMail.weblogic@epml17>
Date: Wed, 21 Mar 2012 14:23:58 -0300
Message-ID: <CABBYNZKbykUbpaci7KAcbkxdth0cZJNDGM2hC5TPsyDZg5skQA@mail.gmail.com>
Subject: Re: [PATCH] avrcp: Handle of GetPlayerApplicationSettingAttributeText pdu
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: chethan.tn@samsung.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 21, 2012 at 2:56 AM, CHETHAN TN <chethan.tn@samsung.com> wrote:
>
> In the above patch the function "attr_to_str" have been taken from audio/media.c file.
> Since there migth be few functions that will be used commonly in audio/avrcp.c and audio/media.c why can't
> such funtions moved to a common file?.

Actually we might want to handle this in media.c, so perhaps we can
reuse the callback to gets an attribute or create a new one to fetch
the text in case of this being dynamically, otherwise just have it
inline in avrcp.h might be fine.


-- 
Luiz Augusto von Dentz
