Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <419CBF0A.2030201@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
References: <418DB442.2050801@uen.org> <41925793.3050404@xmission.com>	 <1100113055.25879.73.camel@pegasus> <419543B3.8050601@xmission.com>	 <1100306337.7349.29.camel@pegasus> <41957BC1.507@xmission.com>	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com> <cbf0aec9041118052714481128@mail.gmail.com>
In-Reply-To: <cbf0aec9041118052714481128@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 18 Nov 2004 08:26:02 -0700

Henryk,

 > I'm currently working (more or less; more less than more) on SBC

Great! Marcel and I don't have a lot of confidence in taking on sbc.

Can I put what you've given us in a module in our bluetooth-alsa 
sourceforge cvs and make you a developer?

I think the structs you have should probably be marked as __attribute__ 
((packed)) so they don't get realigned by gcc. I'm not sure if there's a 
portable alternative.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
