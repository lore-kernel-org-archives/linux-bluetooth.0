Return-Path: <cyrus@holtmann.org>
Message-ID: <4EA90C20.4080009@srdc.com.tr>
Date: Thu, 27 Oct 2011 10:45:36 +0300
From: =?ISO-8859-9?Q?Ali=FEan_YILMAZ?= <alisan@srdc.com.tr>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Compiling BlueZ Thermometer Example
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everybody,
I am trying to compile thermometer example in BlueZ, but getting some 
errors. Firstly, I configured and installed the bluez as explained in 
readme file. I used some configuration parameters like --enable-health 
--enable-thermometer. It gave me .o files for thermometer example, but 
no executable file.
When I tried to link these .o files myself, I got these errors:

/usr/lib/i386-linux-gnu/gcc/i686-linux-gnu/4.5.2/../../../crt1.o: In 
function `_start':
(.text+0x18): undefined reference to `main'
manager.o: In function `thermometer_manager_init':
manager.c:(.text+0x7c): undefined reference to `btd_register_device_driver'
manager.c:(.text+0x8b): undefined reference to `dbus_connection_ref'
manager.o: In function `thermometer_manager_exit':
manager.c:(.text+0xbc): undefined reference to 
`btd_unregister_device_driver'
manager.c:(.text+0xca): undefined reference to `dbus_connection_unref'
collect2: ld returned 1 exit status

Could you please help me to compile and run the thermometer example?

Best regards,
Alisan

-- 
Aliþan YILMAZ

Software Engineer
Software Research, Development and Consultation (SRDC) Ltd.
ODTU Teknokent Silikon Blok Kat:1 No:14
Middle East Technical University Campus
06531 Ankara TURKEY

Email: alisan@srdc.com.tr
Phone: +90 (312) 210 1763
Fax: +90 (312) 210 1837

