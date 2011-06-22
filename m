Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] build: Add support for systemd service configuration
From: Bastien Nocera <hadess@hadess.net>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Jun 2011 12:13:30 +0100
In-Reply-To: <1308275200-17393-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1308275200-17393-1-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1308741214.6042.81.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2011-06-16 at 22:46 -0300, Lucas De Marchi wrote:
> ---
>  .gitignore               |    1 +
>  Makefile.am              |    8 +++++++-
>  configure.ac             |   11 ++++++++++-
>  src/bluetooth.service.in |   12 ++++++++++++
>  4 files changed, 30 insertions(+), 2 deletions(-)
>  create mode 100644 src/bluetooth.service.in

It seems to be pretty much the same as Lennart's patch which I posted
last year:
http://thread.gmane.org/gmane.linux.bluez.kernel/8645

Any reasons why you cooked up your own? What are the differences?

