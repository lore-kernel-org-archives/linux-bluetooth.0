Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43F2F577.6090804@ubuntu.com>
From: Charles Majola <charles@ubuntu.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Unsafe handling of -e option in pand
References: <43F2E0C4.4040204@ubuntu.com> <1139991875.26072.14.camel@localhost>
In-Reply-To: <1139991875.26072.14.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 15 Feb 2006 11:33:43 +0200

Hi again,

While we at that, there is another possible vuln...

http://www.securityfocus.com/archive/1/archive/1/424133/100/0/threaded

Tested in Ubuntu bluez-utils-2.24 and 2.20

Any fix ideas?

--
charles

Marcel Holtmann wrote:

>Hi Charles,
>
>  
>
>> From this bug report :
>>
>>https://launchpad.net/distros/ubuntu/+source/bluez-utils/+bug/6714
>>    
>>
>
>I actually reworked the complete patch. The variable names and the
>coding style was not acceptable. We use tabs instead of whitespaces.
>
>And of course strncpy doesn't include the \0 character, so you need to
>take care of this too. However a patch for it is in the CVS now.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
