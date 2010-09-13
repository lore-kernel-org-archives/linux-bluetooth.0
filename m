Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Sep 2010 23:47:39 +0300
From: Ivan Baidakou <the.dmol@gmail.com>
To: Vladimir Botka <vbotka@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: dund
Message-ID: <20100913234739.2a1cdc3b@gmail.com>
In-Reply-To: <20100912163714.09aac1e3@vaio.site>
References: <20100911214553.0d8bc6f0@gmail.com>
	<16C0AC8E-F3CC-41A8-BE7D-C1BCB7F10CCC@hadess.net>
	<20100912114411.2678ffbe@gmail.com>
	<20100912163714.09aac1e3@vaio.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---=== reply ===---

Hello, 

OK, thanks, it solves the synchronization problem, but this is a
particular solution because it doesn't handles such cases as
web-browsing, ftp-uploading (Palm serves as FTP-server for convenient
file uploading from common desktop software) etc. So, there is need to
DUN-functionality. DUNd is deprecated, what comes instead of?

Best regards,
Ivan Baidakou

---=== original message ===---
Date: Sun, 12 Sep 2010 16:37:14 +0200
Subj: Re: dund
From: Vladimir Botka <vbotka@gmail.com>
To: Ivan Baidakou <the.dmol@gmail.com>


On Sun, 12 Sep 2010 11:44:11 +0300
Ivan Baidakou <the.dmol@gmail.com> wrote:

> You haven't real experience, right?

I have.

# pilot-xfer -p bt:00:07:E0:B3:DD:03 -l

   Listening for incoming connection on bt:00:07:E0:B3:DD:03...
   connected!

   Reading list of databases in RAM...
   AdditDVSData
   ADD050SData
   AdditSystemSData
<snip>

Cheers,
	-vlado

