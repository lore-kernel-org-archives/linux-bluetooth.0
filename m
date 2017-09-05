Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1504622201.6911.16.camel@hadess.net>
Subject: Re: [PATCH] tools/csr_usb: Fix compilation failure
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 05 Sep 2017 16:36:41 +0200
In-Reply-To: <20170905143237.32524-1-hadess@hadess.net>
References: <20170905143237.32524-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2017-09-05 at 16:32 +0200, Bastien Nocera wrote:
> GCC's "format-nonliteral" security check is enabled as an error in
> recent versions of Fedora. Given the reduced scope of use, mark the
> error as ignorable through pragma.

Please ignore, forgot to change the commit message.
