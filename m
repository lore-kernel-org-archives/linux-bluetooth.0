Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid patch (patch 00.13)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051011100057.GA29401@localhost.localdomain>
References: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com>
	 <1128784148.5212.17.camel@blade>
	 <e1effdeb0510081605p56bcd8fcob8fcd77f616c105d@mail.gmail.com>
	 <1128896442.19569.26.camel@blade>
	 <20051010195850.GA23080@localhost.localdomain>
	 <1128977357.7352.1.camel@blade>
	 <20051011100057.GA29401@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1129025702.7352.17.camel@blade>
Mime-Version: 1.0
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
Date: Tue, 11 Oct 2005 12:15:02 +0200

Hi Johan,

> > I applied the patch, but this can't be the final solution. It will
> > produce weird stuff on 64-bit machines:
> 
> Yeah, I suspected that could cause problems since
> sizeof(int) != sizeof(void *) on those machines. I don't think those
> compiler warnings are dangerous though, since they are probably meant to
> warn about possible loss of data which shouldn't happen to us since our
> values always fit within 2 bytes. I don't have a 64bit machine so I
> can't verify this fix, but I think that sizeof(long) should be the same
> as sizeof(void *) on both 32 and 64 bit machines. If that isn't the
> case, the last resort could be to make some automake makro to check the
> actual size of pointer types and add #defines to the code acordingly.
> 
> Anyway, the attached patch uses long for the pointer<->integer
> typecasts. Let me know if it doesn't work.

I applied your patch and the compiler on my 64-bit machine is much
happier now, but I think that we need to allocate a structure and pass
the pointer to it around instead of some casting tricks. Would you mind
fixing it?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
