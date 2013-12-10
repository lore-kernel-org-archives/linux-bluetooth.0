Return-Path: <cyrus@holtmann.org>
Message-ID: <1386663843.1982.5.camel@nuvo>
Subject: Re: [PATCHv2] Fix eir parsing function.
From: Bastien Nocera <hadess@hadess.net>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 10 Dec 2013 09:24:03 +0100
In-Reply-To: <1386663340-12730-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20131129082247.GA6800@x220.p-661hnu-f1>
	 <1386663340-12730-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2013-12-10 at 10:15 +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Currently eir_parse always return 0 but it is checked throughout the code
> (in android/bluetooth code as well in src/adapteri, etc) for return value
                                                  ^
                                                 typo?
> (err < 0) which never happens. Make function eir_parse return void. This
> fixes warnings from static analyzer tools.

