Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1236612318.16880.1656.camel@cookie.hadess.net>
References: <1236301226.3602.2314.camel@cookie.hadess.net>
	 <1236523586.16880.141.camel@cookie.hadess.net>
	 <2d5a2c100903090608kd4ffea6sd9b1746e2362bf2@mail.gmail.com>
	 <1236608040.16880.1580.camel@cookie.hadess.net>
	 <2d5a2c100903090732x6d677dccp747c469b43906f71@mail.gmail.com>
	 <1236612318.16880.1656.camel@cookie.hadess.net>
Date: Mon, 9 Mar 2009 13:40:02 -0300
Message-ID: <2d5a2c100903090940m4aa3b7bbj5c0528ea1b175d5e@mail.gmail.com>
Subject: Re: Broken SDP parsing?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Mar 9, 2009 at 12:25 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Mon, 2009-03-09 at 11:32 -0300, Luiz Augusto von Dentz wrote:
> Problem was sdp_data_alloc() falling back to doing an strlen() on the
> string, instead of taking its existing length into account. That would
> break any strings with NULLs embedded.
>
> The attached patch fixes this. I'm not certain that making this public
> is useful, but feel free to make it so if you feel it's needed.
>
> Cheers
>

Sounds good to me, I will check with Marcel or Johan if they can get
this changes upstream.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
