Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Segmentation fault hcid in textfile.c
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4430C7C3.5050205@service2media.com>
References: <4430C7C3.5050205@service2media.com>
Content-Type: text/plain
Message-Id: <1144423072.2625.26.camel@aeonflux.holtmann.net>
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
Date: Fri, 07 Apr 2006 17:17:52 +0200

Hi Herman,

> this weekend I have been testing with a directional antenna and 
> therefore I have seen a lot of bluetooth devices. I have witnessed a 
> segmentation fault in common/textfile.c twice. After examining the core 
> file of the hcid I found out where the problem is and I have made a 
> patch for it.
> The problem is that the textfile is mapped into memory with an mmap call 
> on line 153, but the file I was writing to (once it was the lastseen 
> file and once the names file) was exactly 8192 bytes. So an exact 
> multiple of the page size. Therefore there is no terminating NULL 
> character in the memory map and the find_key call on line 159, which 
> uses a strstr, will read beyond the boundaries of the memory mapped 
> segment -> SEGV.
> I have made a change to the find_key call and added an extra parameter 
> to indicate the length of the map. It works fine for me but maybe it is 
> not an optimal solution. I have attached the patch.

can you verify that the latest CVS version still segfaults and please
redo the patch against this version and use our coding style.

> +	int start=0;

Must be "int start = 0"

> +		if (0 == strncmp(map+start, key, len)) {

Must be "if (!strcmp(...)) {"

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
