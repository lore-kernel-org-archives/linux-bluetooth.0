Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050427015939.86545.qmail@web20921.mail.yahoo.com>
From: Arch Sayo <a12chi@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-758294282-1114567179=:85949"
Subject: [Bluez-devel] Re: Adding services in the Service Class ID list
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
Date: Tue, 26 Apr 2005 18:59:39 -0700 (PDT)

--0-758294282-1114567179=:85949
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi Marcel,

Thanks for the immediate response.
I appreciate your looking into the concern/issue
that I have.

Here is the part of code where I add the services
in the Service Class ID list.


==========================================
sdp_uuid16_create(&headsetaudiogateway_uuid,
HEADSET_AGW_SVCLASS_ID);
svclass_id[0] = sdp_list_append(0,
&headsetaudiogateway_uuid);
scseq = sdp_list_append(0, svclass_id[0]);
   
sdp_uuid16_create(&genericaudio_uuid,
GENERIC_AUDIO_SVCLASS_ID);
svclass_id[1] = sdp_list_append(0,
&genericaudio_uuid);
scseq = sdp_list_append(scseq, svclass_id[1]);
   
servclasses = sdp_list_append(0, scseq);
sdp_set_service_classes(&record, servclasses);
===========================================

is this the right way of adding the services in
the service class id list?

thanks for your valuable input.

Arch


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-758294282-1114567179=:85949
Content-Type: text/plain; name="file.txt"
Content-Description: file.txt
Content-Disposition: inline; filename="file.txt"

Hi Arch,

> I have been trying to add services in the Service Class ID list like
> as shown below:
>  
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x1112 - HeadsetAudioGateway
>     UUID16 : 0x1203 - GenericAudio
>  
> It seemed that the 2 services have been added successfully.
> However, when I use sdptool to browse for the services, only the last
> service is the one reflected in the service and not both.
>  
> Please advice as on how I can successfully add the 2 services in the
> service class ID list.

show us the source code you are using.

Regards

Marcel




--0-758294282-1114567179=:85949--


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
