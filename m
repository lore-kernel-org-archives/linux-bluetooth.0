Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred =?utf-8?q?Sch=C3=A4ttgen?= <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] D-Bus interfaces
References: <1076265358.2670.36.camel@pegasus> <1076278554.14742.112.camel@akka.yeti.nocrew.org> <1076279508.6869.54.camel@pegasus>
In-Reply-To: <1076279508.6869.54.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200402090015.24318.bluez-devel@schaettgen.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 9 Feb 2004 00:15:24 +0100

On Sunday 08 February 2004 23:31, Marcel Holtmann wrote:
> Do we need a special datatype for the BD_ADDR or is string the best?

I can only speak from my experience with dcop, but I would try to use standard 
types whereever it's possible. In case that there exists a d-bus counterpart 
to the dcop command line utility (dbus-send maybe?), it would make the bluez 
interface more accessible for scripts.
This (besides flexibility issues) is also the reason why I agree with Marcel 
that "simple" return values, but more methods are better than one method that 
returns all the information at once, using nested dictionaries or whatever.

greetings
Fred


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
