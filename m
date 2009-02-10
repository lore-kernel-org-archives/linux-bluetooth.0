Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] tools: Fix memory leaks
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1234223456-30790-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1234223456-30790-1-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Tue, 10 Feb 2009 16:43:12 +0100
Message-Id: <1234280592.12847.33.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Some printfs was using as parameter functions that return dinamic
> allocated memory. Now, we free them!

you patch has been applied, but I had to modify the commit message a lot
to turn it into a little bit more proper English :)

Regards

Marcel


