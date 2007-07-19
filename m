Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <469F6301.3090401@gmail.com>
Date: Thu, 19 Jul 2007 10:11:29 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200707181232.00253.fernando@bluexare.org>	<1ab01fb50707182139y7e3798bej80dd486f23140d8b@mail.gmail.com>
	<200707191216.54531.fernando@bluexare.org>
In-Reply-To: <200707191216.54531.fernando@bluexare.org>
Subject: Re: [Bluez-devel] Obex handle?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fernando,
This question should be asked in the openobex mailing list but who cares.
I had patched the obexftp app to be able to use more than one dongle, 
here's the code that handle that:
if (!src) {
        bacpy(&src_addr, BDADDR_ANY);
else if (!strncmp(src, "hci", 3)) {
    hci_devba(atoi(src + 3), &src_addr);
}
else {
    str2ba(src, &src_addr);
}
if (!device) {
    ret = -EINVAL;
    break;
}

(void) str2ba(devicedup, &bdaddr);
free(devicedup);
ret = BtOBEX_TransportConnect(cli->obexhandle, &src_addr, &bdaddr, 
(uint8_t)port);

> Thanks for your response, Vikas.
>
> first...? There is any problem with the mailing list in sourceforge??
> I can't do any search...
>
> Afortunately, you give me a link within I can search.
> Thanks once.
>
> But this issue talks about how to know if a dongle is free to use it or not...
>
> This can help me, now what I know, but my question is where I select which 
> dongle will be used with OBEX...
>
> So... ,at one moment, I know the dongle I must to use is the "dev_id 0", ok; 
> but..., how I say to OBEX "use the dongle "dev_id 0"".
> In whic method I can select this option??
>
> In HCI is the addr.hci_dev, and in OBEX...? handle.dev_id????
>
> I'm not sure I'm explaning well, but I hope you understand me a little.
>
> Thans a lot,
> Fernando Un


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
