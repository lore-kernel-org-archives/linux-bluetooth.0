Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] =?ISO-8859-1?Q?Cant=B4t?= connect RFCOMM socket:
	Device or resource busy
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <45bf5ff80510140328me0ad427k4c1a8269cc97dccb@mail.gmail.com>
References: <45bf5ff80510140328me0ad427k4c1a8269cc97dccb@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1129288960.5057.44.camel@localhost.localdomain>
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
Date: Fri, 14 Oct 2005 13:22:39 +0200

Hi Artur,

> Im having this problem of getting this error message when i try to run
> the following command: 
> 
>         rfcomm -i hci1 connect 1 00:13:FD:BB:22:3F 9
>         
> 
> Can't connect RFCOMM socket: Device or resource busy
> 
> This happens everytime im downloading a file, i stop the bluetooth on
> my cell phone then i reconnect and try to send the same file. Is there
> a solution to handle this problem without reseting the hci1 ?
> 
> Even if i try to restart the bluetooth daemon the error persists, only
> reseting my machine im able to connect again using the rfcomm command.
> Im using debian sarge with the bluez packages. 
> 
>  
> 
> The output from from hcidump when i try to perform this operation is:

install the latest hcidump and use the -X and -V parameters.

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
