Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Remote name delay
Message-ID: <20051215163313.GA30837@localhost.localdomain>
References: <e1effdeb0512020321g2b492f1cl5c553d7c3b24bfb8@mail.gmail.com> <1133523028.20834.8.camel@blade> <e1effdeb0512020833q3f319166lfe8e63e612a86c4e@mail.gmail.com> <1133548573.20834.83.camel@blade> <e1effdeb0512131359x7ff7a330j435a8bde0779e958@mail.gmail.com> <1134511532.24447.18.camel@blade> <e1effdeb0512141035w5cc40fach9d77ead5df00cf2@mail.gmail.com> <20051214215318.GA25332@localhost.localdomain> <1134624339.5198.18.camel@localhost> <e1effdeb0512150817w6fc28193xe6a09d28cf1cab7a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1effdeb0512150817w6fc28193xe6a09d28cf1cab7a@mail.gmail.com>
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
Date: Thu, 15 Dec 2005 18:33:13 +0200

Hi Claudio,

On Thu, Dec 15, 2005, Claudio Takahasi wrote:
> After your feedbacks, I think it's better remove the
> "GetProperty('info')" in order to avoid confusion. We can create a new
> method called "Info(void)" to retrieve read-only properties returning:
> Address: String
> Manufacturer: String
> HCI Version: String, format TBD
> LMP Version: String, format TBD

Sounds like a good idea.

Johan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
