Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix abuse of kernel headers.
From: David Woodhouse <dwmw2@infradead.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <5.1.0.14.2.20030428143907.10cb0da8@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030425153625.081db0f0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
	<5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
	<5.1.0.14.2.20030425153625.081db0f0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030428143907.10cb0da8@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1051611336.18316.127.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 29 Apr 2003 11:15:36 +0100

On Mon, 2003-04-28 at 22:49, Max Krasnyansky wrote:
> See. It doesn't matter where the field is, compiler has to generate the 
> code that can deal with any alignment.

Consulting the GCC wizards locally confirms that you're correct. 

-- 
dwmw2



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
