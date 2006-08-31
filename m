Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44F7759B.9020203@ibdcon.org.br>
Date: Thu, 31 Aug 2006 20:49:47 -0300
From: Paulo Wollny <paulo.wollny@ibdcon.org.br>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <mailman.44465.1156973920.29847.bluez-users@lists.sourceforge.net>	<44F68535.3060409@shaw.ca>
	<44F6DCB0.3030400@ibdcon.org.br> <44F7028D.3040502@shaw.ca>
In-Reply-To: <44F7028D.3040502@shaw.ca>
Subject: Re: [Bluez-users] bash: syntax error near unexpected token `newline'
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

try hcitool (not hcitools). in case of doubt, type hcito and hit the TAB
key.... in bash shell, it will autocomplete, if it's on the path.


David Armour schrieb:
> hello Paulo
>   
>> Hi,
>> did it work? let me know.
>>   
>>     
> thanks for your interest. i'm keeping a record of this experience, in 
> the hope that others can learn from it.
> now, running:
>
>  >> sudo hcitools auth 00:03:89:53:EC:7F   ## gives:
>  >> sudo: hcitools: command not found      ## !
>
> i'm *looking at* the hcitools icon in /usr/bin, as we speak... [slowly, 
> i turn! inch by inch...step by step!]
>
> what do you think? a permission issue? doesn't sudo take care of that? a 
> path issue? i tried 'sudo /usr/bin/hcitools auth...' just to see. got 
> same result. <curious>
>
>   
>>>>> ## running: >>sudo hidd --connect <00:03:89:53:EC:7F>
>>>>> ## bash: syntax error near unexpected token `newline'        ## gah!
>>>>>           
>
>   
>>>>> Strip < and > from the command... it shoud be:  sudo hidd --connect
>>>>> 00:03:89:53:EC:7F
>>>>>     
>>>>>         
>>>>>           
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>   


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
