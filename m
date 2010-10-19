Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 19 Oct 2010 18:39:13 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: pavan_savoy@ti.com
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: btwilink driver
Message-ID: <20101019203913.GA2322@vigoh>
References: <1287521858-15190-1-git-send-email-pavan_savoy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287521858-15190-1-git-send-email-pavan_savoy@ti.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* pavan_savoy@ti.com <pavan_savoy@ti.com> [2010-10-19 16:57:38 -0400]:

> From: Pavan Savoy <pavan_savoy@ti.com>
> 
> v3 comments
> 
> Marcel, Gustavo, & list,
> Please review this version of patch.
> 
> Anderson,
> I have taken care of most of the comments you had.
> Have re-wrote some of the code commenting you've mentioned.
> Thanks for the comments,
> 
> The other few like -EPERM for platform driver registration is to keep
> it similar to other drivers

Which drivers returns -EPERM to any kind of error? The are many reasons
why the funcion can fail, and you want to give the best error report to the
user. Use EPERM to all of them is just wrong.

>type casting is maintained just to feel safe
> and have style similar to other drivers.

We don't need to feel safe here. Type cast actually can hide errors,
only use them when you really need to cast, in many case here you don't.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
