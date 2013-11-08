Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Nov 2013 13:21:23 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 2/3] android/debug: Convert uuid helper to use uint8_t
 buffer
Message-ID: <20131108112121.GD21468@aemeltch-MOBL1>
References: <1383903349-17487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383903349-17487-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20131108104953.GB28608@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131108104953.GB28608@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Nov 08, 2013 at 12:49:53PM +0200, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Fri, Nov 08, 2013, Andrei Emeltchenko wrote:
> > -char *bt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
> > +char *bt_uuid_t2str(const uint8_t *uuid, size_t len, char *buf)
> 
> I don't understand what you need the len parameter for. Won't you always
> be passing 16 bytes to this function?

OK I'll remove len.

Best regards 
Andrei Emeltchenko 
