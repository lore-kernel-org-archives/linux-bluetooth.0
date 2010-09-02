Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 23:28:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@epx.com.br>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: CSP implementation for MCAP
Message-ID: <20100902202806.GA8391@jh-x301>
References: <4A11989E-5448-43B7-887F-217C54977E22@epx.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4A11989E-5448-43B7-887F-217C54977E22@epx.com.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Thu, Sep 02, 2010, Elvis Pfützenreuter wrote:
> This is the repository for the CSP implementation, rebased over the
> recently accepted MCAP, for your appreciation:
> 
> git://gitorious.org/bluez-epx/bluez-epx.git csp

A couple of quick comments:

- Several of the commits in the tree have the author as
  "epx <epx@xenicall.(none)>". That needs fixing.

- I'm not so happy about all the ifdefs in the code and the way that
  they are used. So this may need some rethinking. Probably we could
  have the code always compiled in and have a runtime variable to
  disable its use.

Johan
