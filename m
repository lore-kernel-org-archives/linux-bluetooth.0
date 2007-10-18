Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b7f7accd0710172130m5cbea8dfp87d58027c045d2aa@mail.gmail.com>
Date: Thu, 18 Oct 2007 10:00:26 +0530
From: "Yogesh Jagtap" <jagtapyb@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1192679922.5231.49.camel@localhost>
MIME-Version: 1.0
References: <1192679922.5231.49.camel@localhost>
Subject: Re: [Bluez-users] [Fwd: Re:  Regarding GetInfo]
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1679815144=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1679815144==
Content-Type: multipart/alternative;
	boundary="----=_Part_19581_16452186.1192681826521"

------=_Part_19581_16452186.1192681826521
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

I dont have problem with signature. For me, I just want device class. I have
written following code.

        msg = dbus_message_new_method_call("org.bluez", "/org/bluez/hci0",
INTERFACE,"GetInfo");
        reply = dbus_connection_send_with_reply_and_block (conn,msg,
-1,&error);
        dbus_message_iter_init (reply, &iter);
        printf("\nSignature::%s",dbus_message_get_signature(reply));
        printf("\nIter
signature::%s",dbus_message_iter_get_signature(&iter));
        dbus_message_iter_recurse (&iter, &dict_iter);
        printf("\ndict_Iter
signature::%s",dbus_message_iter_get_signature(&dict_iter));
        dbus_message_iter_recurse (&dict_iter, &data_iter);
        printf("\ndata_Iter
signature::%s",dbus_message_iter_get_signature(&data_iter));
        while (dbus_message_iter_has_next(&data_iter))
        {
            printf("\ndata
type::%d",(dbus_message_iter_get_arg_type(&data_iter)));
            dbus_message_iter_next(&data_iter);
        }
following is output:
Signature::a{sv}
Iter signature::a{sv}
dict_Iter signature::{sv}
data_Iter signature::s
data type::115

I am expecting all values in the while loop. I want to iterate all adapter
info. Please correct me where I am wrong.

Regards
Yogesh


*From*: Marcel Holtmann
<marcel@holtmann.org<Marcel%20Holtmann%20%3cmarcel@holtmann.org%3e>
> >
> *Reply-To*: BlueZ users <bluez-users@lists.sourceforge.net<BlueZ%20users%20%3cbluez-users@lists.sourceforge.net%3e>
> >
> *To*: BlueZ users <bluez-users@lists.sourceforge.net<BlueZ%20users%20%3cbluez-users@lists.sourceforge.net%3e>
> >
> *Subject*: Re: [Bluez-users] Regarding GetInfo
> *Date*: Wed, 17 Oct 2007 16:25:56 +0200
>
> Hi Yogesh,
>
>  I want to get device class. But DBus API's are available for getting
>  device Major class, Minor class and service class. But no API to get
>  device class. To get Device class I have two options,
>  1. Get device class from GetInfo.
>  2. Get Major class, Minor class and service class and from that
>  construct device class.
>  So I choose first way, But I am not able to get device class.
>
>  To get information about adapter, I have written code like this.
>
>  msg = dbus_message_new_method_call("org.bluez", "/org/bluez/hci0",
>  INTERFACE,"GetInfo");
>          reply = dbus_connection_send_with_reply_and_block (conn,msg,
>  -1,&error);
>          dbus_message_iter_init (reply, &iter);
>          printf("\nSignature::%s",dbus_message_get_signature(reply));
>          cout<<"\nIter
>  signature::"<<dbus_message_iter_get_signature(&iter);
>          dbus_message_iter_recurse (&iter, &dict_iter);
>          cout<<"\ndict_Iter
>  signature::"<<dbus_message_iter_get_signature(&dict_iter);
>          dbus_message_iter_recurse (&dict_iter, &data_iter);
>          cout<<"\ndata_Iter
>  signature::"<<dbus_message_iter_get_signature(&data_iter);
>          while (dbus_message_iter_has_next(&data_iter))
>          {
>             cout<<"\ndata
> type::"<<(dbus_message_iter_get_arg_type(&data_iter));
>              dbus_message_iter_next(&data_iter);
>          }
>
>  But its not working. When I print signatures, it is printing like this
>  Signature::a{sv}
>  Iter signature::a{sv}
>  dict_Iter signature::{sv}
>  data_Iter signature::s
>  data type::115
>
>  And I found that,
>   a{sv} is a dictionary with 's'tring keys and 'v'ariants as values
>
>  So does that mean GetInfo is returning only one key value pair?
>  Or I am missing something?
>
> we fixed the signature in the last release. That might explain an issue.
> Other than that, I can't read C++ code. Use plain C or Python to make me
> look at your code.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.nethttps://lists.sourceforge.net/lists/listinfo/bluez-users
>
>

------=_Part_19581_16452186.1192681826521
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>I dont have problem with signature. For me, I just want device class. I have written following code.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg = dbus_message_new_method_call(&quot;org.bluez&quot;, &quot;/org/bluez/hci0&quot;, INTERFACE,&quot;GetInfo&quot;);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reply = dbus_connection_send_with_reply_and_block (conn,msg, -1,&amp;error);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dbus_message_iter_init (reply, &amp;iter);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;\nSignature::%s&quot;,dbus_message_get_signature(reply));
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;\nIter signature::%s&quot;,dbus_message_iter_get_signature(&amp;iter));<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dbus_message_iter_recurse (&amp;iter, &amp;dict_iter);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;\ndict_Iter signature::%s&quot;,dbus_message_iter_get_signature(&amp;dict_iter));
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dbus_message_iter_recurse (&amp;dict_iter, &amp;data_iter);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;\ndata_Iter signature::%s&quot;,dbus_message_iter_get_signature(&amp;data_iter));<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; while (dbus_message_iter_has_next(&amp;data_iter))
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;\ndata type::%d&quot;,(dbus_message_iter_get_arg_type(&amp;data_iter)));<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dbus_message_iter_next(&amp;data_iter);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>following is output:<br>Signature::a{sv}
<br>Iter signature::a{sv}<br>dict_Iter signature::{sv}<br>data_Iter signature::s<br>data type::115<br><br>I am expecting all values in the while loop. I want to iterate all adapter info. Please correct me where I am wrong.
<br><br>Regards<br>Yogesh<br><br><div><span class="gmail_quote"></span>


  
  

<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>
<b>From</b>: Marcel Holtmann &lt;<a href="mailto:Marcel%20Holtmann%20%3cmarcel@holtmann.org%3e" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">marcel@holtmann.org</a>&gt;<br>
<b>Reply-To</b>: BlueZ users &lt;<a href="mailto:BlueZ%20users%20%3cbluez-users@lists.sourceforge.net%3e" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-users@lists.sourceforge.net</a>&gt;<br>

<b>To</b>: BlueZ users &lt;<a href="mailto:BlueZ%20users%20%3cbluez-users@lists.sourceforge.net%3e" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bluez-users@lists.sourceforge.net</a>&gt;<br>
<b>Subject</b>: Re: [Bluez-users] Regarding GetInfo<br>
<b>Date</b>: Wed, 17 Oct 2007 16:25:56 +0200<br>
<br>
<pre>Hi Yogesh,<br><br> I want to get device class. But DBus API&#39;s are available for getting<br> device Major class, Minor class and service class. But no API to get<br> device class. To get Device class I have two options,
<br> 1. Get device class from GetInfo. <br> 2. Get Major class, Minor class and service class and from that<br> construct device class.<br> So I choose first way, But I am not able to get device class.<br> <br> To get information about adapter, I have written code like this. 
<br> <br> msg = dbus_message_new_method_call(&quot;org.bluez&quot;, &quot;/org/bluez/hci0&quot;,<br> INTERFACE,&quot;GetInfo&quot;);<br>         reply = dbus_connection_send_with_reply_and_block (conn,msg,<br> -1,&amp;error);
<br>         dbus_message_iter_init (reply, &amp;iter); <br>         printf(&quot;\nSignature::%s&quot;,dbus_message_get_signature(reply));<br>         cout&lt;&lt;&quot;\nIter<br> signature::&quot;&lt;&lt;dbus_message_iter_get_signature(&amp;iter);
<br>         dbus_message_iter_recurse (&amp;iter, &amp;dict_iter); <br>         cout&lt;&lt;&quot;\ndict_Iter<br> signature::&quot;&lt;&lt;dbus_message_iter_get_signature(&amp;dict_iter);<br>         dbus_message_iter_recurse (&amp;dict_iter, &amp;data_iter);
<br>         cout&lt;&lt;&quot;\ndata_Iter<br> signature::&quot;&lt;&lt;dbus_message_iter_get_signature(&amp;data_iter); <br>         while (dbus_message_iter_has_next(&amp;data_iter))<br>         {<br>            cout&lt;&lt;&quot;\ndata
<br>type::&quot;&lt;&lt;(dbus_message_iter_get_arg_type(&amp;data_iter));<br>             dbus_message_iter_next(&amp;data_iter); <br>         }<br> <br> But its not working. When I print signatures, it is printing like this
<br> Signature::a{sv}<br> Iter signature::a{sv}<br> dict_Iter signature::{sv}<br> data_Iter signature::s<br> data type::115<br> <br> And I found that, <br>  a{sv} is a dictionary with &#39;s&#39;tring keys and &#39;v&#39;ariants as values
<br> <br> So does that mean GetInfo is returning only one key value pair?<br> Or I am missing something?<br><br>we fixed the signature in the last release. That might explain an issue.<br>Other than that, I can&#39;t read C++ code. Use plain C or Python to make me
<br>look at your code.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.<br>Still grepping through log files to find problems?  Stop.
<br>Now Search log events and configuration files using AJAX and a browser.<br>Download your FREE copy of Splunk now &gt;&gt; <a href="http://get.splunk.com/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
http://get.splunk.com/</a>
_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Bluez-users@lists.sourceforge.net
</a>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>
</pre>
</div>

</blockquote></div><br>

------=_Part_19581_16452186.1192681826521--


--===============1679815144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1679815144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1679815144==--
