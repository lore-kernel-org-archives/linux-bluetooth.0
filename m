Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <450AADD1.2040300@vasmac.com>
Date: Fri, 15 Sep 2006 09:42:41 -0400
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45015406.60208@vasmac.com> <1158321334.5233.13.camel@localhost>
In-Reply-To: <1158321334.5233.13.camel@localhost>
Content-Type: multipart/mixed; boundary="------------060705090303070102030903"
Subject: Re: [Bluez-devel] hcid dbus patches
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060705090303070102030903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> Hi Jose,
>
>   
>> Here are a couple of patches that implement the following
>> commands in dbus-test:
>> GetRemoteClass
>> GetRemoteServiceHandles
>> GetRemoteServiceRecord
>>
>> This required modifications to dbus-sdp.c. The problem was
>> that the call to dbus_message_get_args in this file used a NULL
>> pointer for the error structure. This patch adds a pointer in
>> the same way that dbus-adapter.c calls dbus_messsage_get_args.
>> The end result is that both GetRemoteService* calls now seem
>> to work.
>>     
>
> I am not following that argument. If we don't care about the error code,
> then why should we fill one it. If this is a problem, then the problem
> is in the D-Bus low-level library or the Python bindings.
>
> Regards
>
> Marcel
>   
Hi Marcel,

This was my first hack with dbus. I haven't read the docs so
I'm not sure how it all works. I just noticed that the code in
dbus-adapter.c is working so put the same changes on dbus-sdp.c
and it worked.

I don't think the patch to dbus-sdp.c should be put in. Someone
with more dbus expertise should fix it. The patch to dbus-test
is simple and adds the new commands.

Sorry, that I don't have much time to help in this area. My focus
is to try to figure out how to get multiple SCO channels to work.

Jose


--------------060705090303070102030903
Content-Type: text/x-vcard; charset=utf-8;
 name="jose.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jose.vcf"

begin:vcard
fn:Jose Vasconcellos
n:Vasconcellos;Jose
org:Vas & Mac Enterprises LLC
adr:;;P.O. Box 567;Red Bank;NJ;07701;USA
email;internet:jose@vasmac.com
title:Managing Member and CTO
tel;work:+1 732 978 4680 x102
tel;fax:+1 206 888 6951
url:http://www.vasmac.com
version:2.1
end:vcard


--------------060705090303070102030903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------060705090303070102030903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------060705090303070102030903--
