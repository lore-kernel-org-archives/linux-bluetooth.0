Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0702122156l30de071bu2c56559628a6ac92@mail.gmail.com>
Date: Tue, 13 Feb 2007 11:26:52 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Problem in doing Obex push though multiple connection
	using single adapter
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0640923370=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0640923370==
Content-Type: multipart/alternative;
	boundary="----=_Part_62266_30723375.1171346212562"

------=_Part_62266_30723375.1171346212562
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
   This is the part of code i am using to perform obex push on two
simultaneous connections.The behavior is that while sending through one of
the connections progress in the other process gets stopped and sometimes
causes error.  Please tell me whether my method is correct or not.I provide
the bt addr of the remote devices and their obex push channel via command
line.


int main(int argc,char **argv)
{
    bdaddr_t sourceBdAddr;
    int pid,counter;
    str2ba("80:48:40:B0:A2:02",&sourceBdAddr);
    for (counter = 0;counter < 2;++counter)
    {
        if ((pid = fork()) == 0)
        {
            bdaddr_t destBdAddr;
            struct rfcomm_dev_req req;
            char tempBuf[20];
            int ctl;
            int err;
            int dev = counter;
            int returnVal;
            extern char* addressName;
            str2ba(argv[dev*2 + 1],&destBdAddr);
            addressName = strdup(argv[dev*2 +1]);
            //sprintf(addressName,"%s",argv[dev*2 + 1]);
            printf ("Sending file to %s\n",argv[dev*2 + 1]);
            ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM);
            if (ctl < 0) {
                perror("Can't open RFCOMM control socket");
                exit(1);
            }
            req.dev_id = dev;
            req.flags = 0;
            bacpy(&req.src, &sourceBdAddr);
            bacpy(&req.dst, &destBdAddr);
            req.channel = atoi (argv[dev*2 + 2]);
            sprintf(tempBuf,"/dev/rfcomm%d",dev);
            //mknod(tempBuf,S_IFCHR,req.dev_id);
            {
                char cmdBuf[256];
                remove (tempBuf);
                sprintf(cmdBuf,"mknod %s c 216 %d",tempBuf,dev);
                if (system(cmdBuf) != 0 )
                {
                    fprintf(stderr,"\nError in executng mknod\n");
                    exit(1);
                }
            }
            err = ioctl(ctl, RFCOMMCREATEDEV, &req);
            if (err == EOPNOTSUPP)
                fprintf(stderr, "RFCOMM TTY support not available\n");
            else if (err < 0)
            {
                perror("Can't create device");
            }
            returnVal = obex_push(tempBuf,"tf.jpg");

            memset(&req, 0, sizeof(req));
            req.dev_id = dev;
            err = ioctl(ctl, RFCOMMRELEASEDEV, &req);
            if (err < 0)
            {
                perror("Can't release device");
                exit(1);
            }
            close(ctl);
            if (returnVal ==0)
                printf("Sending file to %s successfull\n",argv[dev*2 + 1]);
            else
                printf("Sending file to %s unsuccessfull\n",argv[dev*2 +
1]);
            exit (0);
        }
    }
    wait();
}



thanks

siddhant

------=_Part_62266_30723375.1171346212562
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>hi,</div>
<div>&nbsp;&nbsp; This is the part of code i am using to perform obex push on two simultaneous connections.The behavior is that while sending through one of the&nbsp;connections progress in the other process gets stopped and sometimes causes error. &nbsp;Please tell me whether my method is correct or 
not.I provide the bt addr of the remote devices and their obex push channel via command line.</div>
<div>&nbsp;</div>
<div>
<p class="MsoPlainText" style="MARGIN: 0in 0in 0pt"><font face="Courier New" size="2">int main(int argc,char **argv)<br>{<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>bdaddr_t sourceBdAddr;<br><span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp; </span>int pid,counter;<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>str2ba(&quot;80:48:40:B0:A2:02&quot;,&amp;sourceBdAddr);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>for (counter = 0;counter &lt; 2;++counter)<br>
<span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>{<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if ((pid = fork()) == 0) <br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>{<br><span style="mso-spacerun: yes">&nbsp;&nbsp; </span><span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>bdaddr_t destBdAddr;<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>struct rfcomm_dev_req req;<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>char tempBuf[20];<br><span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int ctl;<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int err;<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int dev = counter;<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int returnVal;
<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>extern char* addressName;<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>str2ba(argv[dev*2 + 1],&amp;destBdAddr);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</span>addressName = strdup(argv[dev*2 +1]);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>//sprintf(addressName,&quot;%s&quot;,argv[dev*2 + 1]);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>printf (&quot;Sending file to %s\n&quot;,argv[dev*2 + 1]);
<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (ctl &lt; 0) {<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</span>perror(&quot;Can&#39;t open RFCOMM control socket&quot;);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>exit(1);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}<br><span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>req.dev_id = dev;<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>req.flags = 0;<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>bacpy(&amp;req.src, &amp;sourceBdAddr);<br><span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>bacpy(&amp;req.dst, &amp;destBdAddr);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>req.channel = atoi (argv[dev*2 + 2]);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sprintf(tempBuf,&quot;/dev/rfcomm%d&quot;,dev);
<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>//mknod(tempBuf,S_IFCHR,req.dev_id);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>{<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>char cmdBuf[256];
<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>remove (tempBuf);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>sprintf(cmdBuf,&quot;mknod %s c 216 %d&quot;,tempBuf,dev);
<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (system(cmdBuf) != 0 )<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>{<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>fprintf(stderr,&quot;\nError in executng mknod\n&quot;);
<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>exit(1);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}<br><span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>err = ioctl(ctl, RFCOMMCREATEDEV, &amp;req);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (err == EOPNOTSUPP)<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</span>fprintf(stderr, &quot;RFCOMM TTY support not available\n&quot;);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>else if (err &lt; 0)<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>{<br><span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>perror(&quot;Can&#39;t create device&quot;);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>returnVal = obex_push(tempBuf,&quot;tf.jpg&quot;);
<br><br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>memset(&amp;req, 0, sizeof(req));<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>req.dev_id = dev;<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>err = ioctl(ctl, RFCOMMRELEASEDEV, &amp;req);
<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (err &lt; 0)<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>{<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>perror(&quot;Can&#39;t release device&quot;);
<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>exit(1);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>close(ctl);<br><span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (returnVal ==0)<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>printf(&quot;Sending file to %s successfull\n&quot;,argv[dev*2 + 1]);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>else
<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>printf(&quot;Sending file to %s unsuccessfull\n&quot;,argv[dev*2 + 1]);<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>exit (0);<br><span style="mso-spacerun: yes">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>}<br><span style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span>wait();<br>}</font><br></p>
<p class="MsoPlainText" style="MARGIN: 0in 0in 0pt">&nbsp;</p>
<p class="MsoPlainText" style="MARGIN: 0in 0in 0pt">thanks</p>
<p class="MsoPlainText" style="MARGIN: 0in 0in 0pt">siddhant</p></div>

------=_Part_62266_30723375.1171346212562--


--===============0640923370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0640923370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0640923370==--
