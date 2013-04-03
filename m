Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Apr 2013 11:20:18 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/6] Use __sync_* instead of g_atomic_*
Message-ID: <20130403142018.GE2715@samus>
References: <1364943285-12463-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364943285-12463-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 19:54 Tue 02 Apr, Lucas De Marchi wrote:
> These patches fix build with gcc >= 4.8. I'd prefer to use plain ++/-- for
> these refcounts since we are not running multiple threads, but I'm preserving
> the previous behavior.
> 
> Note in some of the commits that the use of atomic operations was wrong, and it
> was not noticed only because there aren't multiple threads.
> 
> It's an RFC because it's only compile-tested (and 'make check' was executed as
> well). Please take a look in the patches and tell me if we want
> to continue with atomic operations. Then I can run some tests tomorrow.

Just to (publicly) clarify a doubt that I had, in case it matters to anyone
else, clang also has these built-ins.


Cheers,
-- 
Vinicius
