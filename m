Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <419543B3.8050601@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
References: <418DB442.2050801@uen.org> <1099830449.6896.14.camel@pegasus>	 <418E4E9C.8070100@xmission.com> <1099846462.6896.26.camel@pegasus>	 <418E6FBF.3090409@xmission.com> <1099863224.6896.57.camel@pegasus>	 <4191AB4B.8060701@xmission.com> <1100076431.25879.49.camel@pegasus>	 <41925793.3050404@xmission.com> <1100113055.25879.73.camel@pegasus>
In-Reply-To: <1100113055.25879.73.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 12 Nov 2004 16:13:55 -0700

Marcel

>>>bug as far as I know. However you don't need this, because it is always
>>>PSM 25 and my sender device simply only looks if a A2DP sink is present
>>>or not.

My a2play.c (committed to cvs btw) opens the l2cap socket and exchanges 
a couple of messages with the bt420n before I have reached something I 
don't know how to interpret:

send avdtp_discover
receive avdtp_discover accept, seid=1
send avdt_get_capabilities for seid=1
receive avdt_get_capabilities accept

The accept looks like this byte-for-byte:

02 -> response accept
02 -> AVDT_GET_CAPABILITIES
01 -> category = media transport
00 -> length of service capabilities = 0
07 -> 7 'elements' follow
06 -> elements[0]
00 ->
00 ->
ff ->
ff ->
02 ->
fa -> elements[6]

The avdt spec drops off sharply around page 86 when talking about what 
comes after the service capabilities length. Any ideas of what to make 
of the elements?

Brad

btw, I did have code in there to be totally sure I had drained off all 
the avdtp_discovery accept packets. Currently the code assumes it will 
only get one seid. The code gets ugly when I try to make it more 
generic. A nonblocking read would help but I haven't figured out how to 
get that.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
