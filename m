Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051207023943.8778.qmail@web32006.mail.mud.yahoo.com>
From: Paul Gustilo <pgustilo@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051206105022.97910.qmail@web32008.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] adding sdp record(additional protocol desc)
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
Date: Tue, 6 Dec 2005 18:39:43 -0800 (PST)

Hi Marcel,

 I would to ask how can you add the additional
protocol  descriptor list in the sdp record... I think
I have the same problem with Collin. I made a similar
function  

int sdp_set_access_protos_attr(sdp_record_t *rec,
const sdp_list_t
 *proto, const uint16_t attr);

to add the additional protocol  descriptor list but i
modified it. This is how i made my function...

int sdp_set_access_protos_attr_additonal(sdp_record_t
*rec, const sdp_list_t
 *proto, const uint16_t attr);
{
   //EVERYTHING IS THE SAME WITH THE ABOVE FUNCTION
EXCEPT FOR

   //EXCEPT FOR THIS
 ++
sdp_attr_add(rec,SDP_ATTR_ADD_PROTO_DESC_LIST,protos);
 -- 
sdp_attr_add(rec,SDP_ATTR_PROTO_DESC_LIST,protos);



}


Will this work?

Thanks,
Paul





 



> Hi Collin,
> 
> > > this won't work, because the additional protocol
>descriptor list is a
> > > sequence of sequence of sequence. Compare this
from my >HCRP capable
> > > printer:
> > 
> > ah mmmh the code I send in works for me, so maybe
it's just >unclean 
> 
> show me how you use it.
>you were right, it doesn't work. sdptool browse just
did >somehow display
>it, but of course the third sequence did not exist
... 
>*remember: Marcel is always right when talking about
BlueZ >stuff*
>so I guess I have to write my own function to do
>SDP_ATTR_ADD_PROTO_DESC_LIST?
> > About the "leng" issue, I thought you would tweak
my patch >anyway so I didn't
> > bothered making it nice ... sorry!
> 
> Make it looks nice and re-send it. I like nice
looking >patches ;)
>... Collin




		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
