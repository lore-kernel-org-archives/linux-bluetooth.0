Return-Path: <cyrus@holtmann.org>
Message-ID: <20110927132332.23237dubrv7x0k08@mail.hendrik-sattler.de>
Date: Tue, 27 Sep 2011 13:23:32 +0200
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Colin Beckingham <colbec@start.ca>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Installation from git did not proceed cleanly?
References: <4E81AA25.6090907@start.ca>
In-Reply-To: <4E81AA25.6090907@start.ca>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Zitat von Colin Beckingham <colbec@start.ca>:

> Hi, a few observations on installation from git repository on a  
> reasonably fresh install of OpenSUSE 11.4. (Previous installations  
> from tar.gz have all run correctly first time.)
>
> 1. Fetching the clone from the temporary repo not a problem
> 2. ./configure instruction from README/INSTALL did not work, no  
> configure found

That one is called boot-strapping and is the same for many projects  
using autoconf. For convenience reasons, it's done before creating  
tarballs. That's probably the reason you are not used to it.

So to create the configure script (and other files), either run "chmod  
+x bootstrap; ./bootstrap" or just "autoreconf -f -i".

HS



