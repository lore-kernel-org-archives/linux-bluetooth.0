Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42393EF0.3090301@prim-time.fr>
From: Xavier Garreau <x.garreau@prim-time.fr>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] A PAN newbie
References: <a0580c510503160953311ea8e2@mail.gmail.com>
In-Reply-To: <a0580c510503160953311ea8e2@mail.gmail.com>
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
Date: Thu, 17 Mar 2005 09:25:20 +0100

> ####
> GN:
> ####
> 
> Edited the file /etc/bluetooth/hci.conf and enabled the "lm accept,
> master" option.
> 
> # hcid -f /etc/bluetooth/hci.conf
> # sdpd
> # sdptool add GN 
> # modprobe bnep
> # pand --listen --role GN -n

Sorry if I'm wrong but i think the newest version of pand do the sdp 
stuff (you don't need sdptool add GN)

Please correct me if I'm wrong ...

Regards,
Xavier Garreau


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
