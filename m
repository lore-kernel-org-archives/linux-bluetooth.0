Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <434BAD41.5020503@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid patch (patch 00.13)
References: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com>	 <1128784148.5212.17.camel@blade>	 <e1effdeb0510081605p56bcd8fcob8fcd77f616c105d@mail.gmail.com>	 <1128896442.19569.26.camel@blade>	 <20051010195850.GA23080@localhost.localdomain>	 <1128977357.7352.1.camel@blade>	 <20051011100057.GA29401@localhost.localdomain> <1129025702.7352.17.camel@blade>
In-Reply-To: <1129025702.7352.17.camel@blade>
Content-Type: text/plain; charset=us-ascii
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 11 Oct 2005 13:17:05 +0100

Marcel Holtmann wrote:
> Johan Hedberg wrote:
>> Yeah, I suspected that could cause problems since
>> sizeof(int) != sizeof(void *) on those machines. I don't think those
>> compiler warnings are dangerous though, since they are probably meant to
>> warn about possible loss of data which shouldn't happen to us since our
>> values always fit within 2 bytes.

Compiler warning are always dangerous.

At the very least, they can obscure the warnings you care about.


>>                                   I don't have a 64bit machine so I
>> can't verify this fix, but I think that sizeof(long) should be the same
>> as sizeof(void *) on both 32 and 64 bit machines. If that isn't the
>> case, the last resort could be to make some automake makro to check the
>> actual size of pointer types and add #defines to the code acordingly.

If you, really, really, really want to stuff integers into pointers then
you should be using the type uintptr_t defined in <inttypes.h>, but even
this isn't safe.

uintptr_t is guaranteed only to be an integer type large enough to hold
all object pointer types (this excludes function pointers). However,
it's not guaranteed that a void * can hold all uintptr_t values or even
that it will hold any consecutive subset. That is, your assertion that
you're safe because all your values fit in 2 bytes is not strictly true
(although it may be true on many architectures).

There's another problem in that even referring to a pointer value that
points to freed memory leads you into undefined behaviour even if you
don't dereference the pointer. This means that code like this:

    free(p);
    if (q != p)
       free(q);

isn't safe. See:

   http://mail-index.netbsd.org/current-users/2005/07/30/0005.html

This makes it safe for a compiler author targetting an architecture
with separate address and data registers to load pointer values into
an address register even if the act of loading an invalid pointer into
a register causes an address exception without the address being
dereferenced.

(If you think about it, this would be quite handy for authors of
debug tools like electric fence - they could generate an exception
as soon as you though about using an invalid pointer rather than
several days later when you finally get round to dereferencing it).

So, if one of the integers you've cast into a void * happens to
match memory that's been freed then you're in trouble.

Basically, this:

  void *p;
  uintptr_t tmp; /* or any suitable integer type such as long */

  /* ... */

  tmp = (uintptr_t) p;

  /* ... */

  p = (void *) tmp;

is safe, but:

  void *tmp;
  uintptr_t *i; /* or any suitable integer type such as long */

  /* ... */

  tmp = (void *) i;

  /* ... */

  i = (uintptr_t) tmp;

Takes you into a world of undefined behaviour.

>> Anyway, the attached patch uses long for the pointer<->integer
>> typecasts. Let me know if it doesn't work.
> 
> I applied your patch and the compiler on my 64-bit machine is much
> happier now, but I think that we need to allocate a structure and pass
> the pointer to it around instead of some casting tricks. Would you mind
> fixing it?

This is the right solution.

Speaking from experience, saying "I only need to store an integer so I
can save myself a malloc and, instead, cast it to a pointer" is a false
economy. Next week you'll suddenly find the implementation gets easier
if you can store two integers, then the week after, an integer and a
char * and so on.

On a resource constrained embedded system where the cost of the extra
allocation may be excessive, the only solution is to redesign the
library from the ground up replacing the void * with a union of a
void * and a long.

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
