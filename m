Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH BlueZ] Fix batostr(): return the bdaddr in the right
 order
From: Marcel Holtmann <marcel@holtmann.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Sep 2011 19:53:45 +0200
In-Reply-To: <1316015179-6474-1-git-send-email-ospite@studenti.unina.it>
References: <1316015179-6474-1-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316022826.1937.44.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

> lib/bluetooth.c::batostr() is returning the bdaddr reversed, fix this
> and put more arguments on the same line to look more like ba2str().

this would be breaking existing API. So NAK.

Regards

Marcel


