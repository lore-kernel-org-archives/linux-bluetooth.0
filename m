Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] simple relay scatternet and a question
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <265ff2abcc101.heejune@snut.ac.kr>
References: <265ff2abcc101.heejune@snut.ac.kr>
Content-Type: text/plain
Message-Id: <1107245443.8848.23.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 01 Feb 2005 09:10:43 +0100

Hi,

> I  am working on contrcuting a simple relay scatternet with CSR-based
> USB dongle.
> 
> Yesterday I made it that 4 dongle relay data from top to down and dwon
> to top, writing a utility code based on rfcomm program in bluez-util.
> 
> I works fine!
> 
>  
> 
>     A ------------------>B-----------------> C ------------------> D
> 
>        M                        S   M                      S     M
> S
> 
>  
> 
>  
> 
> But, while I am running it serveral time. I got a one difficult
> problem "Can't bind: Address already in Use!"
> 
> This is old problem in TCP/IP socket program, when the server clashes
> without close the socket, so that the well-kown (or fixed anyway)
> 
> cannot be resused again for a several minutes in typical TCP/IP socket
> program.   
> 
>  
> 
> But! what is the port in rfcomm socket? Is this channel numer? or
> board address?.
> 
> And Can I use socketopt system call for the rfcomm socket ?  for
> RESUSE option!
> 
> Also, the socket address is not freed for even 30 minutes, while
> usually TCP/IP port is can be resued after several minutes!
> 
> What part of kernel stack has something with this??? rfcomm.o ???? 

what kernel version do you use and what about showing us your code?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
