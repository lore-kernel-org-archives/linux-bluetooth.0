Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] send appointment to cellular phone
From: Taneli =?ISO-8859-1?Q?V=E4h=E4kangas?= <taneli.vahakangas@netsonic.fi>
To: gargarmel@gmx.net
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <5770C039-928B-43A4-9D7A-B6A849625422@gmx.net>
References: <5770C039-928B-43A4-9D7A-B6A849625422@gmx.net>
Content-Type: text/plain
Message-Id: <1125329935.10748.4.camel@newer.loc>
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
Date: Mon, 29 Aug 2005 18:38:54 +0300

On Thu, 2005-08-25 at 23:59 +0200, lists wrote:
> hey,
> 
> i'm just programming a shopping list for my flat-sharing-folks and  
> want to distribute shopping-lists as appointments onto our cellular  
> phones.
> 
> well, i have some early testing experience with bluez about 2 years  
> ago (with multisync). but now i just want to send an appointment  
> (.ics file) to my device (i.e Siemens S55) and accept it there as  
> appointment in my calendar.
> 
> i tried to send a single .ics file via obexftp, but it's just placed  
> on the file-system of my phone. no question whether i want to import  
> it to the calendar.
> 
> does anyone have a hint, how i should send this and in what format?

Have you tried obex object push (OPUSH) instead of obexftp? At least
with Nokia phones there is a tremendous difference between the two.

	Taneli




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
