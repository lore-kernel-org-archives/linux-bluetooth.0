Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42538BC5.7060106@futurlink.com>
From: Pedro Monjo Florit <pedro.monjo@futurlink.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] malloc & free
References: <424C259C.9000201@futurlink.com> <1112554711.8263.13.camel@pegasus>
In-Reply-To: <1112554711.8263.13.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------080602010607080001030901"
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
Date: Wed, 06 Apr 2005 09:12:05 +0200

This is a multi-part message in MIME format.
--------------080602010607080001030901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
>Hi Pedro,
>
>  
>>In the application I am developing, I want to log some information about 
>>Bluetooth devices, pretty much like "sdptool browse" and "hcitool info" 
>>do. In the code of these applications, there are calls to some library 
>>functions like hci_dflagstostr(), hci_lmtostr()... that create a string 
>>with information about the device (flags, features, etc.).
>>
>>The problem with these functions is that they call malloc(), expecting 
>>the caller to call free(). The problem with that is that this approach 
>>is not save, as it is not guaranteed that calling malloc() in a library 
>>function and free() in the main program works. In fact, I have seen a 
>>segmentation fault doing that.
>>    
>
>explain why this is not safe.
>  
I am not an expert in these issues, but I have read many times that 
there is no guarantee that the malloc/free implementation is the same in 
the main program and in the libraries. This is due to how the different 
modules are compiled: compiler version, compile flags, etc. But, as I 
said, I am not 100% sure. I am quite sure that I have read this for 
Windows, but maybe (probably) Linux is different.
>  
>>AFAIK, there are two alternatives: either the library functions expect a 
>>buffer (and its size) to be filled or malloc() and free() are both done 
>>within the library, which means creating a new library function call for 
>>freeing buffers allocated with malloc(). Are any of this alternatives 
>>implemented or on the roadmap? What workaround do you suggest?
>>    
>
>We can do that, but it is not on my roadmap. Send my patches for it and
>I will review them.
The easiest way to do it (and to continue with the actual API without 
modifications) would be to have a function call like:

void hci_str_free(char *str)
{
    free(str);
}

So after a call to hci_dflagstostr() (for example), the resulting 
pointer should be freed with hci_str_free(). In any case, there is one 
exception: hci_dtypetostr(); it returns a pointer to static data.

Cheers,

Pedro

--------------080602010607080001030901
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Marcel Holtmann wrote:
<blockquote cite="mid1112554711.8263.13.camel@pegasus" type="cite">
  <pre wrap="">Hi Pedro,

  </pre>
  <blockquote type="cite">
    <pre wrap="">In the application I am developing, I want to log some information about 
Bluetooth devices, pretty much like "sdptool browse" and "hcitool info" 
do. In the code of these applications, there are calls to some library 
functions like hci_dflagstostr(), hci_lmtostr()... that create a string 
with information about the device (flags, features, etc.).

The problem with these functions is that they call malloc(), expecting 
the caller to call free(). The problem with that is that this approach 
is not save, as it is not guaranteed that calling malloc() in a library 
function and free() in the main program works. In fact, I have seen a 
segmentation fault doing that.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
explain why this is not safe.
  </pre>
</blockquote>
I am not an expert in these issues, but I have read many times that
there is no guarantee that the malloc/free implementation is the same
in the main program and in the libraries. This is due to how the
different modules are compiled: compiler version, compile flags, etc.
But, as I said, I am not 100% sure. I am quite sure that I have read
this for Windows, but maybe (probably) Linux is different.<br>
<blockquote cite="mid1112554711.8263.13.camel@pegasus" type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">AFAIK, there are two alternatives: either the library functions expect a 
buffer (and its size) to be filled or malloc() and free() are both done 
within the library, which means creating a new library function call for 
freeing buffers allocated with malloc(). Are any of this alternatives 
implemented or on the roadmap? What workaround do you suggest?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
We can do that, but it is not on my roadmap. Send my patches for it and
I will review them.</pre>
</blockquote>
The easiest way to do it (and to continue with the actual API without
modifications) would be to have a function call like:<br>
<br>
void hci_str_free(char *str)<br>
{<br>
&nbsp;&nbsp;&nbsp; free(str);<br>
}<br>
<br>
So after a call to hci_dflagstostr() (for example), the resulting
pointer should be freed with hci_str_free(). In any case, there is one
exception: hci_dtypetostr(); it returns a pointer to static data.<br>
<br>
Cheers,<br>
<br>
Pedro<br>
</body>
</html>

--------------080602010607080001030901--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
