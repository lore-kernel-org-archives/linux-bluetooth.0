Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <419D45AE.5060306@patbert.com>
From: Patrick <patbert@patbert.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Using windows breaks bluetooth in linux? huh
References: <419AE72F.3030307@patbert.com>	 <1100673867.7208.128.camel@pegasus>  <419B6990.7020009@patbert.com>	 <1100704877.7607.8.camel@pegasus>  <419BB514.3030807@patbert.com>	 <1100723967.7164.11.camel@pegasus>  <419C118D.8050309@patbert.com> <1100762008.7164.15.camel@pegasus>
In-Reply-To: <1100762008.7164.15.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 18 Nov 2004 20:00:30 -0500

Ah wonderful! It took a few tries but it is happy again!

Now in the future if I find myself back in windows will I be able to use 
it there without fear of disabling it in linux or should I just not use 
it in windows any more?

Thanks again,

Patrick

Marcel Holtmann wrote:
> Hi Patrick,
> 
> 
> the problem is the same. Error 0x05 means "Authentication failure" and
> this means that the link key is wrong. Since we don't have an easy way
> to delete a single paired device from our list, you need to remove the
> file /etc/bluetooth/link_key and restart the hcid. After that, your
> keyboard should re-pair again.
> 
> 
>>Thanks again for your help! You are by far the most helpful developer I 
>>have ever met.
> 
> 
> Thanks for these nice words.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: InterSystems CACHE
> FREE OODBMS DOWNLOAD - A multidimensional database that combines
> robust object and relational technologies, making it a perfect match
> for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
